
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
  def ejercicio1(year)
    result_ex1 = Array.new()
    @files.each() do |file|
      aux = file.exercise_1(year)
      if aux != nil
        result_ex1.push(aux)
      end
    end
    #return result_ex1
  
  puts result_ex1.sort!()
  end #ejercicio1
  
#################################################  ejercicio 2  #################################################################
  def ejercicio2()
    result_ex2 = Array.new()
    @files.each() do |file|
      if file.at_or_do() == 1
        if file != nil
        if not result_ex2.include?(file.magazine_name())
          result_ex2.push(file.exercise_2())
        end
        end
      end
    end
    return result_ex2.sort!()
  end
  #puts result_ex2.sort!()
  #end ejercicio2
  
#################################################  ejercicio 3  #################################################################
  def ejercicio3(acronym)
    result_ex3 = Array.new()
    @files.each() do |file|
      aux = file.exercise_3(acronym)
      if not result_ex3.include?(aux)
        if aux!=nil
          result_ex3.push(aux)
        end
      end
    end
    return result_ex3
  end
  #puts result_ex3.sort!()
  #end ejercicio3
  
#################################################  ejercicio 4  #################################################################
  def ejercicio4(magazine_name,acronym)
    result_ex4 = Array.new()
    #coger acronimo y nombre de revista por pantalla
    @files.each() do |file|
      aux = file.exercise_4(magazine_name,acronym)
      if not result_ex4.include?(aux)
        if aux != nil
          result_ex4.push(aux)
        end
      end
    end
    return result_ex4
  end
#  result_ex4.sort_by! do |item|
#      item[:title]
#  end
  #puts result_ex4.sort!()
  #end ejercicio4
 
#################################################  ejercicio 5  #################################################################
  def ejercicio5(year)
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
    result_ex5 = Array.new()
    @files.each() do |file|
      if file.year() === year #pedir por pantalla
        result_ex5.push(file.exercise_5)
      end
    end
    return result_ex5
  end
#  puts result_ex5[1][0].expanded_form
#  puts result_ex5[1][0].acronym 
  
  
#################################################  ejercicio 6  #################################################################
  def ejercicio6(id)
    result_ex6 = Array.new()
    @files.each() do |file|
      file.exercise_6(id)
    end
  end
  #end ejercicio6
  
#################################################  ejercicio 7  #################################################################
  def ejercicio7()
    @files.each() do |file|
      aux = file.exercise_7()
      if aux!=nil
        puts aux
      end
    end
  end

#################################################  ejercicio 8  #################################################################
  def ejercicio8(acronym)
    @files.each() do |file|
      file.exercise_8(acronym)
    end
  end
    
#################################################  ejercicio 9  #################################################################
  def ejercicio9
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
  end#ejercicio9
  
  
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
  
  