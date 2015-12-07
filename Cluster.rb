class Cluster
  attr_accessor :number
  attr_accessor :groups
  
  def initialize()
    @number = 0
    @groups = Array.new()
  end
end