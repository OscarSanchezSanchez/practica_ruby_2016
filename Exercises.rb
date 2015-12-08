
class Exercises
  require "Files.rb"
  require "FileUtils.rb"
  require "Articles.rb"
  require "Documents.rb"
  require "Acronym.rb"
  require "Cluster"

  attr_accessor :files
  
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
  end
  #fin lectura y formateo de ficheros
  
  #ejercicio 1
  def ejercicio1(year)
    result_ex1 = Array.new()
    @files.each() do |file|
      aux = file.exercise_1(year)
      if aux != nil
        result_ex1.push(aux)
      end
    end
    return result_ex1
  end
  #puts result_ex1.sort()
  #end ejercicio1
  
  #ejercicio 2
  def ejercicio2()
    result_ex2 = Array.new()
    @files.each() do |file|
      if file.at_or_do() == 1
        if not result_ex2.include?(file.magazine_name())
          result_ex2.push(file.exercise_2())
        end
      end
    end
    return result_ex2
  end
  #puts result_ex2.sort!()
  #end ejercicio2
  
  #ejercicio3
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
  
  #ejercicio4
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
 
  #ejercicio5
  def ejercicio5()
    result_ex5 = Array.new()
    @files.each() do |file|
      if file.year() === "2015" #pedir por pantalla
        result_ex5.push(file.exercise_5)
      end
    end
    return result_ex5
  end
#  puts result_ex5[1][0].expanded_form
#  puts result_ex5[1][0].acronym 
  
  
  #ejercicio6
  def ejercicio6
    result_ex6 = Array.new()
    files.each() do |file|
      file.exercise_6("3667821")
    end
  end
  #end ejercicio6
  

#  
#  #ejercicio7
#  files.each() do |file|
#    aux = file.exercise_7()
#    if aux!=nil
#      puts aux
#    end
#  end  
#  #end ejercicio7
#
#  #ejercicio8
#  files.each() do |file|
#    file.exercise_8("ALS")
#  end
#  
#
#  
####  aux =["hola manolo lama","adios paco gonzalez","pedo con sida"]
####    
####    bb = Array.new()
####    for i in (0..2)
####     bb[i] = aux[i].to_s.split(" ")
####    end
####    for i in (0..1)
####      bb[0].concat(bb[i+1]) 
####    end
####  puts bb[0].reverse().to_s
####   
  #ejercicio9
  def ejercicio9
    utils = LCS.new() 
    number_cluster = 1
    cluster = Cluster.new()
    for i in (0..@files.length-1)
      file = @files[i]
      acronym_string1 = "" #string donde pondremos toda la lista de acronimos de un fichero 
      for k in (0..file.acronyms.length-1)
        acronym_string1 = acronym_string1 + file.acronyms[k] + " "
      end
      cluster.groups().push(Array.new())
      cluster.groups()[i].push(file.ID()+" - "+file.title())
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
        if (utils.similars(file.title(),file_compare.title(),10)) && (utils.similars(acronym_string1,acronym_string2,20)) 
          cluster.groups()[i].push(file_compare.ID()+" - "+file_compare.title())
        end
      end
      if cluster.groups()[i].length() <= 1 
        cluster.groups()[i].clear()
      else
        number_cluster = number_cluster + 1
      end
    end
    cluster.number = (number_cluster)
    return cluster
  end
end 
  
  
  