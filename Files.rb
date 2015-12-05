class Files
  require "FileUtils"
  
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
end
#end of Class Files

