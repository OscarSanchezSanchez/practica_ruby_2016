class Acronym
  attr_accessor :acronym , :expanded_form
  
  def initialize()
    @acronym = ""
    @expanded_form = ""
  end
  
  def initialize(a,expanded)
    @acronym = a
    @expanded_form = expanded
  end

  def show_acronym()
    if ((@acronym != nil) && (@expanded_form != nil)&& (@acronym != "") && (@expanded_form != ""))
      puts @acronym + " -- " + @expanded_form 
    end  
  end
end