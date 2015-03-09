module FileCompress
	require 'zip/zip'
	require 'find'
	require 'fileutils'
	#http://dev.mensfeld.pl/2011/12/using-ruby-and-zip-library-to-compress-directories-and-read-single-file-from-compressed-collection/
	def zip(dir, zip_dir, remove_after = false)
    	Zip::ZipFile.open(zip_dir, Zip::ZipFile::CREATE)do |zipfile|
      		Find.find(dir) do |path|
        		Find.prune if File.basename(path)[0] == ?.
        		dest = /#{dir}\/(\w.*)/.match(path)
        		# Skip files if they exists
        		begin
          			zipfile.add(dest[1],path) if dest
        		rescue Zip::ZipEntryExistsError
        		end
      		end
    	end
    	FileUtils.rm_rf(dir) if remove_after
  	end
end