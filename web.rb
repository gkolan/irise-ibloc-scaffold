require 'sinatra'
require 'zip'
require 'FileUtils'
require './app/helpers/make_ibloc_xml'
require './app/helpers/create_folder_structure'
require './app/helpers/file_compress'

configure do
  set :erb, :layout => :'layouts/project_layout'
  set :public_folder, 'views/static-files'
end

helpers MakeIblocXml, FileCompress, CreateFolderStructure

get '/' do
	redirect '/make_ibloc'
end

get '/guide' do
	erb :guide
end

get '/make_ibloc' do
  #FileUtils.rm_rf(Dir.glob('ibloc-zip-files/*'))
  erb :ibloc_scaffold_form
end

post '/form_scaffold' do
	  
    namespace 	  = params[:ibloc_name_space].downcase
	  name 		      = params["ibloc_name"].downcase
    irise_version = params["ibloc_version"]
	  version 	    = params["ibloc_version"]
    type          = params["ibloc_type"]
    time_now      = Time.now.to_i
    
    begin
        # CreateFolderStructure Module uses MakeIblocXml, FileCompress Module and then send zip file
        make_ibloc_scaffold_and_send(namespace,name,irise_version,version,type,time_now)
    rescue Exception => e  
        puts e.message  
        #puts e.backtrace.inspect
    end
end