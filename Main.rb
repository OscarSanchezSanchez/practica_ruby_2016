class Main
  require "Exercises"
  require "Acronym"
  
  
  ejercicios = Exercises.new()
  #puts ejercicios.ejercicio1("2015")
  #puts ejercicios.ejercicio2()
  #puts ejercicios.ejercicio3("ALS")
  #puts ejercicios.ejercicio4("PLoS ONE","USH")
  #a = ejercicios.ejercicio5()
  #puts a[0][0].expanded_form
  #puts ejercicios.ejercicio6()
  #puts ejercicios.ejercicio7()
  #puts ejercicios.ejercicio8()
  a =  ejercicios.ejercicio9()
  #puts ejercicios.ejercicio10()

  
  for i in (1..a.number())
    puts "Cluster "+i.to_s
    puts a.groups()[i]
  end
end