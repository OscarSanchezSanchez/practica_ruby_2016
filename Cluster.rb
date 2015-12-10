class Cluster
  attr_accessor :number
  attr_accessor :groups
  
  def initialize()
    @groups = Array.new()
  end
end