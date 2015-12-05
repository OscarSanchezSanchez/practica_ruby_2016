class Files
  require "FileUtils"
  require "LCS"
  
  attr_reader :ID 
  attr_reader :year
  attr_reader :title
  attr_reader :sections
  attr_reader :at_or_do # 0 para inicializar, 1 si es articulo y 2 si es documento
  
  def initialize()
    @ID = ''
    @year = ''
    @title = ''
    @sections = Array.new()
    @at_or_do = 0
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
  
  #ejercicio6
  def exercise_6(id)
    if id === self.ID()
      list_p = self.acronym_list_with_parenthesis()
      list = self.acronym_list()
      sections = self.sections()
      for i in (0..list.length-1)
        aux = Files.count_acronym(list[i],list_p[i],sections).to_s
        puts list[i]+": aparece " + aux +" veces"
      end
      
    end
  end
  
  #ejercicio7
  def exercise_7
    list = self.acronym_list
    if list.empty?
      return "titulo: "+ self.title+"\n" + "identificador: " + self.ID()+"\n"
    else
      return nil
    end
  end
  #end ejercicio7
  
  #funcion para encontrar la lista de acronimos de los ficheros
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
        if utils.similars(word,acronym,95) || utils.similars(word,acronym_p,95)
          cont += 1
        end
      end
    end
    return cont
  end
  
  protected
  def self.is_acronym(acronym)
    #meter algo para que no coja palabras entre parentesis que sean todo en minuscula
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
    if acronym[last_index] === '.'
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
  
  protected
  def self.is_number? string
    true if Float(string) rescue false
  end
  
end
#end of Class Files
