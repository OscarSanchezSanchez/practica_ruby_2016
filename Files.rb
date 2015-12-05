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
  #ejercicio7
  def exercise_7
    list = self.acronym_list
    if list.empty?
      return "titulo: "+ self.title+"\n" + "identificador: " + self.ID()+"\n"
    else
      return nil
    end
  end
  
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
  
  def acronym_list
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
    Files.clean_acronym(array_return)
    return array_return.sort!()
  end
  
  protected 
  def self.clean_acronym(list)
    list.each do |acronym|
      acronym.delete!('();.,:')
    end
  end
  
  
  protected
  def self.is_acronym(acronym)
    utils = LCS.new()
    last_index = acronym.length-1
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
    if acronym[0] === '(' && acronym[last_index] === ')'
      aux = acronym.upcase()
      return utils.similars(aux,acronym,75)
    end
  end
end
#end of Class Files
