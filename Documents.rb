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
  
  #ejercicio1
  def exercise_1(year)
    if (year == self.year())
      return self.title()
    else
      return nil
    end
  end
  
  #ejercicio3
  def exercise_3(acronym)
    super(acronym)
  end
  #end ejercico3
end
#end of class Documents
