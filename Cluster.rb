class Cluster
#  attr_accessor :number
  attr_accessor :groups
  
  def initialize()
    @groups = Array.new()
  end
  
  def exercise_7()
    cluster_number = 1
    @groups.each() do |group|
      number_of_files = group.size()/2
      join_acronyms = Array.new()
      
      #obtenemos una lista con los acronimos de todos los ficheros de un grupo
      group.each() do |file|
        join_acronyms.concat(file.acronyms)
        join_acronyms.uniq!()
      end
      join_acronyms.each() do |acronym|
        appearances = 0
        acronyms_appearances = Array.new()
        group.each() do |file|
          if file.acronyms.include?(acronym)
            appearances += 1
          end
        end
#        puts appearances
        if appearances > number_of_files
          puts "--Cluster " + cluster_number.to_s
          puts "Acrónimo:" + acronym
          puts "Aparariciones:" + appearances.to_s
          puts "Mínimo:" + number_of_files.to_s 
        end
      end
      cluster_number+=1
    end
  end
  
  def exercise_8()
    return @groups.sort_by {|x| x.length}
  end
  
  private 
  def bubble_sort(array)
    n = array.length
    loop do
      swapped = false
  
      (n-1).times do |i|
        if array[i] > array[i+1]
          array[i], array[i+1] = array[i+1], array[i]
          swapped = true
        end
      end
  
      break if not swapped
    end
  
    array
  end
end