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
      puts "1. Mostrar los títulos de los documentos ordenados alfabéticamente y publicados en un año dado."
      puts "2. Mostrar el listado de revistas en las que se han publicado los artículos científicos de toda la colección."
      puts "3. Dado un acrónimo, buscarlo en los diferentes documentos y mostrar los títulos de aquellos que contengan el acrónimo."
      puts "4. Dado el nombre de una revista y un acrónimo, mostrar los títulos de los artículos publicados en dicha revista que contengan el acrónimo."
      puts "5. Dado un año de publicación, mostrar para cada documento publicado en ese año el listado de acrónimos que contiene acompañados de sus formas expandidas."
      puts "6. Dado un identificador de documento, mostrar un listado de los acrónimos que contiene, acompañado del número de veces que aparece cada acrónimo en el documento."
      puts "7. Mostrar los títulos e identificador de todos aquellos documentos que no contengan ningún acrónimo."
      puts "8. Dado un acrónimo, mostrar información de todos los documentos que aparezcan en el acrónimo."
      puts "9. Mostrar los grupos de documentos según su temática."
      puts "10. Calcular ciertas estadísticas relacionadas con los grupos de documentos similares:"
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
      when 1
        puts "introduzca un año"
        x = gets.chomp
        puts ejercicios.ejercicio1(x).sort! + "\n"
      when 2
        puts ejercicios.ejercicio2()
      when 3
        puts "introduzca un acronimo"
        x = gets.chomp
        puts ejercicios.ejercicio3(x)
      when 4
        puts "introduzca un acronimo"
        acronym = gets.chomp
        puts "introduzca un nombre de revista"
        name = gets.chomp
        puts ejercicios.ejercicio4(name,acronym) 
      when 5
        puts "introduzca un año"
        x = gets.chomp
        ejercicios.ejercicio5(x) 
      when 6
        puts "introduzca un identificador"
        x = gets.chomp
        ejercicios.ejercicio6(x)
      when 7
        ejercicios.ejercicio7() 
      when 8
        puts "introduzca un acronimo"
        x = gets.chomp
        ejercicios.ejercicio8(x) 
      when 9
        ejercicios.ejercicio9()
      when 10
        ejercicios.ejercicio10() 
      else 
        puts "opcion no valida."
      end
    end
#    
  
    

  #puts ejercicios.ejercicio1("2015")
  #puts ejercicios.ejercicio2()
  #puts ejercicios.ejercicio3("ALS")
  #puts ejercicios.ejercicio4("PLoS ONE","USH")

  #puts ejercicios.ejercicio6()
  #puts ejercicios.ejercicio7()
  #puts ejercicios.ejercicio8()
  #ejercicios.ejercicio9()
#  #puts ejercicios.ejercicio10()
#
#  
