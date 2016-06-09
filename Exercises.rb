
class Exercises
  require "Files.rb"
  require "FileUtils.rb"
  require "Articles.rb"
  require "Documents.rb"
  require "Acronym.rb"
  require "Cluster"

  attr_accessor :files, :groups
  
  
  def initialize()
    #leemos todos los archivos y los metemos en un array de string
    utils = FileUtils.new()
    files_without_format = utils.read_without_format()
    
    
    @files = Array.new() #array de objetos Files, sobre el que realizaremos los diferentes ejercicios
      
      
    #identificamos que tipo de texto es y lo formateamos al tipo de dato concreto(article o document)
    files_without_format.each() do |file|
      if file[0][1] == 'W'
        x = Documents.new(file)
        @files << x
      else
        x= Articles.new(file)
        @files << x
      end
    end
    @groups = clusters
  end
  #fin lectura y formateo de ficheros
  
#################################################  ejercicio 1  #################################################################
  def ejercicio1(acronym)
    result_ex1 = Array.new()
    @files.each() do |file|
      aux = file.exercise_1(acronym)
      if not result_ex1.include?(aux)
        if aux!=nil
          result_ex1.push(aux)
        end
      end
    end
    return result_ex1
  end

#################################################  ejercicio 2  #################################################################
  def ejercicio2(magazine_name,acronym)
    result_ex2 = Array.new()
    #coger acronimo y nombre de revista por pantalla
    @files.each() do |file|
      aux = file.exercise_2(magazine_name,acronym)
      if not result_ex2.include?(aux)
        if aux != nil
          result_ex2.push("-"+aux)
        end
      end
    end
    if result_ex2.empty? 
      return "No hay acronimos para esta revista"
    else
      return result_ex2
    end
  end
  
#################################################  ejercicio 3  #################################################################
  def ejercicio3(year)
    list = search_expanded_form_by_year(year)
    for i in (0..list.length-1)
      for j in (0..list[i].length())
        if list[i][j] != nil && list[i][j] != ""
          puts list[i][j].show_acronym
        end
      end
    end
  end
  
  def search_expanded_form_by_year(year)
    result_ex3 = Array.new()
    @files.each() do |file|
      if file.year() === year #pedir por pantalla
        result_ex3.push(file.exercise_3)
      end
    end
    return result_ex3
  end

  
#################################################  ejercicio 4  #################################################################
  def ejercicio4(id)
    result_ex6 = Array.new()
    @files.each() do |file|
      file.exercise_4(id)
    end
  end
  #end ejercicio4
 
#################################################  ejercicio 5  #################################################################
  def ejercicio5()
    @files.each() do |file|
      aux = file.exercise_5()
      if aux!=nil
        puts aux
      end
    end
  end  
  
#################################################  ejercicio 6  #################################################################
def ejercicio6
  if @groups.groups().empty?
    puts "no se ha obtenido ningún grupo"
  else   
    for i in (0..(@groups.groups().length()-1))
      puts "Cluster " + (i+1).to_s
      for j in (0..(@groups.groups()[i].length()-1))
        puts @groups.groups()[i][j].ID()+ " - " + @groups.groups()[i][j].title()
      end
    end
  end
end
#funcion que inicializa el atributo groups de la clase exercises, para despues mostrar los clusters en la llamada a la funcion ejercicio9
def clusters
  utils = LCS.new() 
  number_cluster = 1
  cluster = Cluster.new()
  for i in (0..@files.length-1)
    file = @files[i]
    acronym_string1 = "" #string donde pondremos toda la lista de acronimos de un fichero 
    for k in (0..file.acronyms.length-1)
      acronym_string1 = acronym_string1 + file.acronyms[k] + " "
    end
    cluster.groups()[number_cluster-1] = Array.new()
    cluster.groups()[number_cluster-1].push(file)
    for j in (0..@files.length-1)
      if (j == i)
        next
      end
      file_compare = @files[j]
      acronym_string2 = "" #string donde pondremos toda la lista de acronimos de un fichero 
      for k in (0..(file.acronyms.length-1))
        if file_compare.acronyms[k] !=nil
          acronym_string2 = acronym_string2 + file_compare.acronyms[k] + " "
        end
      end
      if (utils.similars(file.title(),file_compare.title(),15)) && (utils.similars(acronym_string1,acronym_string2,25)) 
        cluster.groups()[number_cluster-1].push(file_compare)
      end
    end
    if cluster.groups()[number_cluster-1].length() <= 1 
      cluster.groups().delete_at(number_cluster-1)
    else
      number_cluster = number_cluster + 1
    end#if
  end#for grande
  return cluster
end#ejercicio6

  
#################################################  ejercicio 7  #################################################################
def ejercicio7()
  #supondremos que "la mayoría de los grupos" es que el acrónimo aparezca en más de la mitad de los grupos como poco 
  @groups.exercise_7()#se inplementa en la clase cluster
end


#################################################  ejercicio 8  #################################################################
def ejercicio8
  sorted_cluster = @groups.exercise_8()
  sorted_cluster.reverse!()
  number_cluster = 1
  sorted_cluster.each() do |cluster|
    puts "Cluster " + number_cluster.to_s + " según su tamaño"
    number_cluster+=1
    
    cluster.each() do |file| 
      puts file.ID() + " - " + file.title()
    end
    puts "\n"
  end
end

    
#################################################  ejercicio 9  #################################################################
  def ejercicio9
    if @groups.groups().empty?
      puts "no se ha obtenido ningún grupo"
    else
      result_ex9 = Array.new
      cluster_number = 0
      @groups.groups().each do |group|
        cluster_number += 1
        if group.size > 2
          puts "Cluster " + cluster_number.to_s + "\n"
          group.each do |file|
            puts file.ID()+ " - " + file.title()
          end
          puts "\n"
        end
      end
    end
  end
  
#################################################  ejercicio 10  #################################################################
  def ejercicio10()  
    puts "numero de grupos: " + @groups.groups().length().to_s
    puts "numero medio de documentos por grupo: " + self.groups_average().to_s
    puts "numero medio de articulos cientificos por grupo: " + self.average_article().to_s
    puts "numero medio de documentos de wikipedia por grupo: " + self.average_document().to_s
    puts "numero de grupos con todos los documentos de la misma fecha: " + self.equal_year()[0].to_s
    puts "numero de grupos con documentos de fechas variadas: " + self.equal_year()[1].to_s
    puts "numero de grupos con solo un documento: 0" #la funcion que crea los grupos excluye los grupos de un solo documento, ya que he considerado que para ser grupo necesita mas de un documento
  end
  
  protected
  def groups_average()
    counter = 0
    for i in (0..(@groups.groups().length()-1))
      for j in (0..(@groups.groups()[i].length()-1))
        counter = counter + 1
      end
    end
    return (counter/@groups.groups().length())
  end
  
  def average_article()
    counter = 0
    for i in (0..(@groups.groups().length()-1))
      for j in (0..(@groups.groups()[i].length()-1))
        if @groups.groups()[i][j].at_or_do == 1
          counter = counter + 1
        end
      end
    end
    return (counter/@groups.groups().length())
  end
  
  
  def average_document()
    counter = 0
    for i in (0..(@groups.groups().length()-1))
      for j in (0..(@groups.groups()[i].length()-1))
        if @groups.groups()[i][j].at_or_do == 2
          counter = counter + 1
        end
      end
    end
    return (counter/@groups.groups().length())
  end
  
  
  def equal_year()
    k=0
    counter_equal = 0
    counter_not_equal = 0  
    for i in (0..(@groups.groups().length()-1))
      for j in (1..(@groups.groups()[i].length()-1))
        if @groups.groups[i][k].year() != @groups.groups[i][j].year()
          counter_not_equal = counter_not_equal + 1 
          break
        end
      end
    end
    result = Array.new()
    counter_equal = @groups.groups().length() - counter_not_equal
    result.push(counter_equal)
    result.push(counter_not_equal)
    return result
  end
end#class
  
  