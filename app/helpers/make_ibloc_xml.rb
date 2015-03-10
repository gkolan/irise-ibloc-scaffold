require 'nokogiri'
module MakeIblocXml
  	def create_ibloc_xml_file(namespace,name,irise_version,version,type,folder_name)

  		xmlns 				        = "http://www.irise.com/schema/ibloc" 
  		displayName 		      = "Smashing Magazine Chart" 
  		description			      = "Lorem ipsium Lorem ipsium Lorem ipsium Lorem ipsium Lorem ipsium"
  		canvasImageFileName   = 'statue-of-liberty-canvas.jpg'
      iconImageFileName     = 'statue-of-liberty-icon.png'
      defaultWidth 		      = 600 
		  defaultHeight 		    = 400
      containsDrag          = true

      # Meta Data
        createdBy             = 'John Doe'
        contributors          = 'Jane Doe, Ram Krishna'
		    supportedBrowsers     = 'Internet Explorer, Firefox, Chrome'
		    connectionRequired    = false
        helpUrl               = 'http://www.irise.com'
        releaseDate           = '2010-12-21' # YYYY-MM-DD

      # CDATA Info
      htmlContent             = '<img src="http://placehold.it/600x400">'
      
      # Preload Files
        # Stylesheets
        stylesheets           = ["irise/#{namespace}/#{name}/#{version}/resources/stylesheets/ibloc.css",'http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css']

        # Javascripts
        javascripts           = ["irise/#{namespace}/#{name}/#{version}/resources/javascripts/ibloc.js",'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js']

      # Properties

        # Property

      # Make XML

		  xml = Nokogiri::XML('<?xml version = "1.0" encoding = "UTF-8" standalone ="yes"?>')
			builder = Nokogiri::XML::Builder.with(xml) do |xml|
  				xml.ibloc( 'xmlns'=>xmlns, 'type'=>type, 'namespace'=>namespace, 'name'=>name, 'version'=>version, 'productVersion'=>irise_version) do
  				xml.displayName(displayName)
  				xml.description(description)
  				xml.canvasImage('resources' + '/' + 'images' + '/' + canvasImageFileName)
  				xml.iconImage('resources' + '/' + 'images' + '/' + iconImageFileName)
  				xml.defaultWidth(defaultWidth)
  				xml.defaultHeight(defaultHeight)
          xml.containsDrag(containsDrag)
          xml.metadata { 
            xml.createdBy(createdBy)
            xml.contributors(contributors)
            xml.supportedBrowsers(supportedBrowsers)
            xml.connectionRequired(connectionRequired)
            xml.helpUrl(helpUrl)
            xml.releaseDate(releaseDate)
          }
          xml.preload {
            xml.stylesheets {
              stylesheets.each do |stylesheet|
                xml << '<stylesheet src=' + "#{stylesheet}" +'></stylesheet>'
              end
            }
            xml.scripts {
              javascripts.each do |javascript|
                xml << '<script src=' + "#{javascript}" +'></script>'
              end
            }
          }
      		xml.content { 
            xml.cdata(htmlContent) 
          }
          
  			end
		end

		File.open('ibloc-zip-files/' + folder_name + '/' + namespace + '/' + name + '/' + version + '/' + 'ibloc.xml', 'w') do |file|
  			file.write builder.to_xml
		end
  	end
end