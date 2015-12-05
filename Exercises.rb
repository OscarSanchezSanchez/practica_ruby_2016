class Exercises
  require "Files.rb"
  require "Articles.rb"
  require "Documents.rb"
  require "FileUtils.rb"
  attr_reader :files #array de objetos Files, sobre el que realizaremos los diferentes ejercicios
  
  def initialize()
    utils = FileUtils.new()
    files_without_format = utils.read_without_format()   
    @files = Array.new()
    #identificamos que tipo de texto es y lo formateamos al tipo de dato concreto(article o document)
    files_without_format.each() do |file|
      if file[0][1] == 'W'
        x = Documents.new(file)
        @files << x
      else
        x= Articles.new(file)
        @files << x
      end
    end
  end
end