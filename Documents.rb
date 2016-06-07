#begin of class documents
class Documents < Files
  def initialize()
    super()
  end
  def initialize(file)
      @ID = file[0]
      @year = file[1]
      @title = file[2]
      @sections = take_sections_document(file)
      @at_or_do = 2
      @acronyms= self.acronym_list()
      @acronyms_parenthesis = self.acronym_list_with_parenthesis()
  end

  def take_sections_document(file)
    cont = 0
    found = false
    sections = []
    for i in (0..file.length()-1)
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
  
#################################################  ejercicio 1  #################################################################
  def exercise_1(acronym)
    super(acronym)
  end

#################################################  ejercicio 3  #################################################################

  
  #muestra la información de un documento de la wikipedia
  def show_information
    puts "-" *15
    puts "Title: "+ @title + " " + @year
    puts "Introduction: " + @sections[2]
    puts "Section number: " + self.count_sections().to_s
    puts "Sections: "
    sections = self.show_sections()
    sections.each() do |section|
      puts section.to_s
    end
    puts "-" *15
    puts "\n"
  end
end
#end of class Documents
