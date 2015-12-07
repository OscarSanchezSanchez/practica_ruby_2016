class Acronym
  attr_accessor :acronym
  attr_accessor :expanded_form
  
  def initialize()
    @acronym = ""
    @expanded_form = ""
  end
  
  def initialize(a,expanded)
    @acronym = a
    @expanded_form = expanded
  end
  def get_acronym()
    return @acronym
  end
end