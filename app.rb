require 'sinatra'
require 'zip'
require 'FileUtils'

configure do
  set :erb, :layout => :'layouts/project_layout'
end

get '/' do
	redirect '/make_ibloc'
end

get '/app_guide' do
	erb :app_guide
end

get '/make_ibloc' do
  erb :ibloc_scaffold_form
end

post '/form_scaffold' do
	
	@namespace 	= params[:namespace].downcase
	@name 		= params[:name].downcase
	@version 	= params[:version]

  	TIME_NOW = Time.now.to_i
  	FILE_NAME = @namespace + '-' + @name + '-' + @version + "_#{TIME_NOW}.zip"

  	Zip::File.open("zip-files/#{FILE_NAME}", Zip::File::CREATE) do |zipfile|
  		zipfile.add('readme.txt', 'ibloc-files/readme.txt')
  		zipfile.add('ibloc-css-sample.css', 'ibloc-files/css-files/ibloc-css-sample.css')
  		zipfile.add('ibloc-js-sample.js', 'ibloc-files/js-files/ibloc-js-sample.js')
  	end
	#FileUtils.rm_rf(Dir.glob('zip-files/*'))
	send_file "zip-files/#{FILE_NAME}", :disposition => :inline
	
end