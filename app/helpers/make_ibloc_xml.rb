require 'fileutils'
module MakeIblocXml
  	def new_folder(name)
  		name = name.downcase!
    	FileUtils.mkdir_p name
  	end
end