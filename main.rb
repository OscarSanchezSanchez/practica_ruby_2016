
  
  require "Files.rb"
  require "FileUtils.rb"
  require "Articles.rb"
  require "Documents.rb"

  #leemos todos los archivos y los metemos en un array de string
  utils = FileUtils.new()
  files_without_format = utils.read_without_format()
  
  
  files = [] #array de objetos Files, sobre el que realizaremos los diferentes ejercicios
    
    
  #identificamos que tipo de texto es y lo formateamos al tipo de dato concreto(article o document)
  files_without_format.each() do |file|
    if file[0][1] == 'W'
      x = Documents.new(file)
      files << x
    else
      x= Articles.new(file)
      files << x
    end
  end
  #fin lectura y formateo de ficheros
  
  #ejercicio 1
  result_ex1 = Array.new()
  files.each() do |file|
    aux = file.exercise_1("2015")
    if aux != nil
      result_ex1.push(aux)
    end
  end
  #puts result_ex1.sort()
  #end ejercicio1
  
  #ejercicio 2
  result_ex2 = Array.new()
  files.each() do |file|
    if file.at_or_do() == 1
      if not result_ex2.include?(file.magazine_name())
        result_ex2.push(file.exercise_2())
      end
    end
  end
  #puts result_ex2.sort!()
  #end ejercicio2
  
  #ejercicio3
  result_ex3 = Array.new()
  files.each() do |file|
    aux = file.exercise_3('ALS')
    if not result_ex3.include?(aux)
      if aux!=nil
        result_ex3.push(aux)
      end
    end
  end
  #puts result_ex3.sort!()
  #end ejercicio3
  
  #ejercicio4
  result_ex4 = Array.new()
  #coger acronimo y nombre de revista por pantalla
  files.each() do |file|
    aux = file.exercise_4("PLoS ONE","USH")
    if not result_ex4.include?(aux)
      if aux != nil
        result_ex4.push(aux)
      end
    end
  end
#  result_ex4.sort_by! do |item|
#      item[:title]
#  end
  #puts result_ex4.sort!()
  #end ejercicio4
  
  #ejercicio6
  result_ex6 = Array.new()
  files.each() do |file|
    file.exercise_6("3667821")
  end
  
#  #ejercicio7
#  files.each() do |file|
#    aux = file.exercise_7()
#    if aux!=nil
#      puts aux
#    end
#  end  
#  #end ejercicio7
  
  puts "hola,".chomp(',')

  