#begin of class Articles
class Articles < Files
  attr_reader :magazine_name
  @magazine_name
  
  def initialize()
    super()
    @magazine_name = ''
  end
  
  def initialize(file)
      @ID = file[1]
      @magazine_name = file[0]
      @year = file[2]
      @title = file[4]
      @sections = take_sections_article(file)
      @at_or_do = 1
      @acronyms = self.acronym_list()
      @acronyms_parenthesis = self.acronym_list_with_parenthesis()
  end
  
  #funcion que comprueba si un string es un articulo

  
  def take_sections_article(file)
    cont = 0
    found = false
    sections = []
    for i in (5..file.length()-1)
        if (file[i]=="--") && (not found) then
          for j in (i..file.length())
            sections[cont] = file[j]
            cont = cont + 1 
          end
          found = true
        end
        if found
          i = i + 1
        end
    end
    return sections
  end
  
  #ejercicio1
  def exercise_1(year)
    if (year == self.year())
      return self.title()
    else
      return nil
    end
  end
  
  #ejercicio2
  def exercise_2()
    return self.magazine_name()
  end  
  #ejercicio3
  def exercise_3(acronym)
    super(acronym)
  end
  #ejercicio4
  def exercise_4(magazine_name,acronym)
    found = false
    # magazine_name == self.magazine_name() no compara los string bien 
    if (self.magazine_name().include?(magazine_name))
      aux = self.sections()
      aux.each() do |section|
        if section.include?(acronym)
          found = true
          break
        end
      end
      if found
        return self.title()
      else
        return nil
      end 
    else
      return nil 
    end
  end
  
  #muestra la información de un articulo
  def show_information
    puts "-" *15
    puts "Title: "+ self.title()
    puts "Abstract: " + self.sections[1]
    puts "Section number: " + self.count_sections().to_s
    sections = self.show_sections()
    puts "Sections: "
    sections.each() do |section|
      puts section.to_s
    end
    puts "-" *15
    puts "\n"
  end
end
#end of class Articles




