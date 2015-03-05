require 'sinatra'
require 'zip'
require 'FileUtils'
require './app/helpers/create_file_directory'

configure do
  set :erb, :layout => :'layouts/project_layout'
  set :public_folder, 'views/static-files'
end

helpers CreateFileDirectory

get '/' do
	redirect '/make_ibloc'
end

get '/guide' do
	erb :guide
end

get '/make_ibloc' do
  FileUtils.rm_rf(Dir.glob('ibloc-zip-files/*'))
  erb :ibloc_scaffold_form
end

post '/form_scaffold' do
	NAMESPACE 	= params[:ibloc_name_space].downcase
	NAME 		    = params["ibloc_name"].downcase
	VERSION 	  = params["ibloc_version"]

  TIME_NOW = Time.now.to_i
  FOLDER_NAME = NAMESPACE + '-' + NAME + '-' + VERSION + "_#{TIME_NOW}"

  FileUtils.mkdir_p("ibloc-zip-files/#{FOLDER_NAME}/#{NAMESPACE}/#{NAME}/#{VERSION}/resources/")
  FileUtils.cd("ibloc-zip-files/#{FOLDER_NAME}/#{NAMESPACE}/#{NAME}/#{VERSION}/resources/") do
    #FileUtils.mkdir %w( images stylesheets javascripts )
  end
  FileUtils.cp_r "ibloc-scaffold-files/images", "ibloc-zip-files/#{FOLDER_NAME}/#{NAMESPACE}/#{NAME}/#{VERSION}/resources/"
  
=begin
  Zip::File.open("ibloc-zip-files/#{FOLDER_NAME}", Zip::File::CREATE) do |zipfile|
    zipfile.add('readme.txt', 'ibloc-scaffold-files/readme.txt')
  	zipfile.add('ibloc-css-sample.css', 'ibloc-scaffold-files/css-files/ibloc-css-sample.css')
  	zipfile.add('ibloc-js-sample.js', 'ibloc-scaffold-files/js-files/ibloc-js-sample.js')
  end
  send_file "ibloc-zip-files/#{FILE_NAME}", :disposition => :inline
=end

end