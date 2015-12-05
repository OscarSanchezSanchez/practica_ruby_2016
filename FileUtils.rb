class FileUtils 
     
 def list_files(folder_name)
    file_list = []
    Dir.new(folder_name).each do |archivo|
        file_list << "docsUTF8/"+archivo
    end
    
    file_list.delete('docsUTF8/.')
    file_list.delete('docsUTF8/..')
    return file_list
 end

 def read_file(file_name)
   content = ""
   File.open(file_name, "r") do |f|
       while linea = f.gets
          content += linea
       end
   end
   
   return content
 end
  
  def read_without_format()
    utils = FileUtils.new
    list = utils.list_files('docsUTF8')
    files = []
    x = 0
    list.each do |file|
      files[x] =  utils.read_file(file).split("\n")
      x+=1
    end
    return files
  end
  
end