class Main
  require "Exercises"
  require "Acronym"
 
  #inicializamos un objeto Exercises para desde el menu llamar a los diferentes ejercicios de la practica
    attr_accessor :option
    
    def initialize()
      @option = 999
    end
    
    def show_menu()
      puts "Esta en el menu de elección de ejercicio, introduzca el número del ejercicio que desea ejecutar. \nSi desea terminar introduzca un '0' \n \n"
      puts "1. Dado un acrónimo, buscarlo en los diferentes documentos y mostrar los títulos de aquellos que contengan el acrónimo."
      puts "2. Dado el nombre de una revista y un acrónimo, mostrar los títulos de los artículos publicados en dicha revista que contengan el acrónimo."
      puts "3. Dado un año de publicación, mostrar para cada documento publicado en ese año el listado de acrónimos que contiene acompañados de sus formas expandidas."
      puts "4. Dado un identificador de documento, mostrar un listado de los acrónimos que contiene, acompañado del número de veces que aparece cada acrónimo en el documento."
      puts "5. Mostrar los títulos e identificador de todos aquellos documentos que NO contengan ningún acrónimo."
      puts "6. Mostrar los grupos de documentos según su temática."
      puts "7. Mostrar los acrónimos más representativos de cada grupo(aparecen almenos en la mitad de los documentos del grupo)"
      puts "8. Mostrar los diferentes grupos de documentos similares, ordenados de acuerdo a su tamaño"
      puts "9. Mostrar aquellos grupos cuyo tamaño sea superior a dos."
      puts "10.volver a leer los ficheros, solo dar si se incluyen nuevos ficheros a la carpeta docsUTF8"
      puts "0. Salir del menu"
    end
end

  #inicio del menu para ejecutar la practica
    main = Main.new()
    puts "inicializando las funciones espere por favor \n \n"
    ejercicios = Exercises.new() #inicializa los atributos @groups(donde estan las agrupaciones de ficheros) y @files(donde estan los textos formateados
    while main.option != 0 
      main.show_menu()
      main.option = gets.to_i
      case main.option
      when 0
        puts "gracias por usar la app"
        break
      when 1
        puts "introduzca un acronimo"
        x = gets.chomp
        puts ejercicios.ejercicio1(x)
      when 2
        puts "introduzca un acronimo"
        acronym = gets.chomp
        puts "introduzca un nombre de revista"
        name = gets.chomp
        puts ejercicios.ejercicio2(name,acronym)
      when 3
        puts "introduzca un año"
        x = gets.chomp
        ejercicios.ejercicio3(x) 
      when 4
        puts "introduzca un identificador"
        x = gets.chomp
        ejercicios.ejercicio4(x)
      when 5
        ejercicios.ejercicio5() 
      when 6
        ejercicios.ejercicio6()
      when 7
        ejercicios.ejercicio7() 
      when 8
        ejercicios.ejercicio8() 
      when 9
        ejercicios.ejercicio9()
      when 10
        ejercicios = Exercises.new()
      else 
        puts "opcion no valida."
      end
    end
