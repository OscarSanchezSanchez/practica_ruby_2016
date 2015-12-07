class Files
  require "FileUtils"
  require "LCS"
  require "Acronym.rb"
  
  attr_reader :ID 
  attr_reader :year
  attr_reader :title
  attr_reader :sections
  attr_reader :acronyms
  attr_reader :acronyms_parenthesis
  attr_reader :at_or_do # 0 para inicializar, 1 si es articulo y 2 si es documento
  
  def initialize()
    @ID = ''
    @year = ''
    @title = ''
    @sections = Array.new()
    @at_or_do = Array.new()
    @acronyms = Array.new()
    @acronyms_parenthesis = Array.new()
  end
  
  def acronym_list()
    #implementan las clases hijas
  end

  def exercise_1(year)
    #implemantan las clases hijas
  end
  
  def exercise_2
    #implemantada en la clase hija article, ya que nombre de revista solo esta disponible en esta
  end

  #ejercicio3
  def exercise_3(acronym)
    found = false
    self.sections().each() do |section|
      if section != nil 
        if section.include?(acronym)#or (section.include?("("+acronym+")"))
            found = true
            break
        end
      end
    end
    if found 
      return self.title()
    end
  end

  #end ejercicio3
  
  #ejercicio4
  def exercise_4(magazine_name,acronym)
    #implementación en la clase hija articles
  end
  #end ejercicio4
  
  #ejercicio5
  def exercise_5
    return take_expanded_form()
  end
  
  
  #ejercicio6
  def exercise_6(id)
    if id === self.ID()
      list_p = self.acronyms()
      list = self.acronyms_parenthesis()
      sections = self.sections()
      for i in (0..list.length()-1)
        if list[i] != nil && list_p[i] != nil
          puts list[i]
          aux = Files.count_acronym(list[i].to_s,list_p[i],sections).to_s
          puts list[i]+": aparece " + aux +" veces"
        end
      end
      
    end
  end
  
  #ejercicio7
  def exercise_7
    
    if @acronyms.empty?
      return "titulo: "+ self.title+"\n" + "identificador: " + self.ID()+"\n"
    else
      return nil
    end
  end
  #end ejercicio7
  
  #ejercicio8 
  def exercise_8(acronym)
    if self.acronyms().include?(acronym)
      self.show_information()
    end
  end
  #end ejercicio8
  
  
#funciones para sacar la lista de acronimos de un fichero  
  #funcion para encontrar la lista de acronimos de los ficheros
  protected
  def acronym_list_with_parenthesis
    array_return = Array.new()
    sections = self.sections()
    sections.each() do |section|
      section_aux = section.to_s.split(' ')
      section_aux.each() do |word|
        if word != "\n"
          if Files.is_acronym(word) && word.length > 3
            array_return.push(word)
          end
        end
      end
    end
    return array_return
  end
  
  #lista de acronimos sin parentesis 
  protected
  def acronym_list
    array_return = Array.new()
    sections = self.sections()
    sections.each() do |section|
      section_aux = section.to_s.split(' ')
      section_aux.each() do |word|
        if word != "\n"
          if Files.is_acronym(word) && word.length > 3 && !(array_return.include?(word) )
            array_return.push(word)
          end
        end
      end
    end
    Files.clean_acronym(array_return)
    return array_return
  end
  
  protected 
  def self.clean_acronym(list)
    list.each do |acronym|
      acronym.delete!('();.,:')
    end
  end
  
  #funcion que cuenta el numero de apariciones de un acronimo
  protected
  def self.count_acronym(acronym,acronym_p,sections)#primer argumento es el acronimo, el segundo el acronimo con parentesis y el tercero las secciones
    cont = 0
    utils = LCS.new()
    sections.each() do |section|
      section = section.to_s.split(' ')
      section.each() do |word|
        if word != nil
          if utils.similars(word,acronym,95) || utils.similars(word,acronym_p,95)
            cont += 1
          end
        end
      end
    end
    return cont
  end
  
  protected
  def self.is_acronym(acronym)
    utils = LCS.new()
    last_index = acronym.length-1
    if acronym.length > 10
      return false
    end
    if acronym[last_index] === ';'
      acronym.chomp(';')
      last_index = acronym.length-2
    end
    if acronym[last_index] === ':'
      acronym.chomp(':')
      last_index = acronym.length-2
    end
    if acronym[last_index] === '.'
      acronym.chomp('.')
      last_index = acronym.length-2
    end
    if acronym[last_index] === ','
      acronym.chomp(',')
      last_index = acronym.length-2
    end
    if acronym[0] === '(' && acronym[last_index] === ')'#mejorar el filtrado, no coge bien los acronimos 
      aux = acronym.upcase()
      if aux[1] === acronym[1] && aux[2] === acronym[2] && !Files.is_number?(acronym[2])
        return utils.similars(aux,acronym,90)
      end
    end
  end
#end funciones lista de acronimos
 
#funciones para recuperar los acronimos con su forma expandida 
  protected 
  def take_expanded_form
    list_p = self.acronyms_parenthesis()
    sections = self.sections()
    result = Array.new()
    aux = Files.split_all_sections(sections) 
    
    for i in (0..list_p.length-1)
      result[i] = search_expanded(list_p[i],aux)
    end
    return result 
  end
  
  
  #funcion que busca un acronimo y devuelve un objeto acronimo con su forma expandida y el nombre del acronimo
  def search_expanded(acronym,sections_split)
    aux = ""
    #puts sections_split
    for i in (0..sections_split.length-1)
      if sections_split[i+(acronym.length-2)] != nil
        if acronym === sections_split[i] 
          if (acronym.length-2) == 6
            aux = sections_split[i+7] + " " + sections_split[i+6] + " " +  sections_split[i+5] + " " + sections_split[i+4] + " " +  sections_split[i+3] + " " + sections_split[i+2] + " " + sections_split[i+1]  
            break
          end
          if (acronym.length-2) == 5
            aux = sections_split[i+6] + " " + sections_split[i+5] + " " +  sections_split[i+4] + " " + sections_split[i+3] + " " +  sections_split[i+2] + " " + sections_split[i+1]  
            break
          end
          if (acronym.length-2) == 4
            aux = sections_split[i+5] + " " + sections_split[i+4] + " " +  sections_split[i+3] + " " + sections_split[i+2] + " " +  sections_split[i+1]  
            break
          end
          if (acronym.length-2) == 3
            aux = sections_split[i+4] + " " + sections_split[i+3] + " " +  sections_split[i+2] + " " + sections_split[i+1]  
            break
          end
          if (acronym.length-2) == 2
            aux = sections_split[i+3] + " " + sections_split[i+2] + " " +  sections_split[i+1]
            break
          end
        end
      end
    end
    return Acronym.new(acronym,aux)
  end
#end funciones para recuperar forma expandida   
  protected
  def self.is_number? string
    true if Float(string) rescue false
  end
 
  
  #funcion que cuenta el numero de secciones de un fichero
  protected
  def count_sections
    count = 0
    self.sections().each() do |section|
      if section != nil
        if Files.is_number?(section[0])
          count = count + 1
        end
      end
    end
    return count
  end
  
  #funcion que muestra la cabecera de las secciones de un fichero
  protected
  def show_sections
    array_return = Array.new()
    self.sections().each() do |section|
      if section != nil
        if Files.is_number?(section[0])
          array_return.push(section)
        end
      end
    end
    return array_return
  end
  
  protected
  def self.split_all_sections(sections)
    i = 0
    for i in (0..sections.length-2)
      if sections[i+1] != nil
        sections[0]<<" ".concat(sections[i+1])
      end
    end
    return sections[0].split(" ").reverse!()

     # sections[0] = sections[0].to_s.split(" ")
    
##fallo al hacer split sobre todas las secciones   
#################################################
#    for i in (0..sections.length-2)
#      aux[0].concat(aux[i+1])
#    end
#    
#    aux2 = aux[0].reverse().to_s
#    puts aux2
  end
  #funcion que muestra el contenido según lo indica el enunciado de la practica
  protected 
  def show_information
    #se implementa en las clases hijas 
  end
end
#end of Class Files
