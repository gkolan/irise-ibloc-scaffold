module CreateFolderStructure
    def make_ibloc_scaffold_and_send(namespace,name,irise_version,version,type,time_now)

        folder_name = namespace + '-v' + version + '-' + name + '_' + time_now.to_s

        FileUtils.mkdir_p("ibloc-zip-files/#{folder_name}/#{namespace}/#{name}/#{version}/resources/")
        FileUtils.cp_r "ibloc-scaffold-files/images", "ibloc-zip-files/#{folder_name}/#{namespace}/#{name}/#{version}/resources/"
        FileUtils.cp_r "ibloc-scaffold-files/stylesheets", "ibloc-zip-files/#{folder_name}/#{namespace}/#{name}/#{version}/resources/"
        FileUtils.cp_r "ibloc-scaffold-files/javascripts", "ibloc-zip-files/#{folder_name}/#{namespace}/#{name}/#{version}/resources/"
        
        # Make ibloc.xml from MakeIblocXml module
        create_ibloc_xml_file(namespace,name,irise_version,version,type,folder_name)
        # FileCompress Module
        zip("ibloc-zip-files/#{folder_name}", "ibloc-zip-files/#{folder_name}.zip", true)
        # Send Zip File
        send_file "ibloc-zip-files/#{folder_name}.zip", :disposition => :inline
    end
end