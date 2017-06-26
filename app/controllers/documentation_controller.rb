class DocumentationController < ApplicationController
  def index
  	## check for login
  	## role fetch
  	# role = 'Admin'
  	# role = 'Manager'
  	# role = 'TeleCaller'
  	role =  params[:role] if params[:role].present?
  	require 'net/http'
	uri = URI("http://tentacledoc.herokuapp.com?role=#{role}&token=oLH2uvgLT5DbHz8gUaCB8KSade8MkGuAwvTkHG4S")
	req = Net::HTTP.get(uri)
	@html = req #show result
  end

  def saveFile
    require 'base64'
    require 'uri'

    path = File.join Rails.root, 'public', 'uploads'
    uri = params[:file_data]
    data = uri.slice(uri.index(',')+1..-1)

    FileUtils.mkdir_p(path) unless File.exist?(path) 

    File.open(File.join(path, 'temp.csv'), 'wb') do |file|
      if uri.include?('base64')
        file.write(Base64.decode64(data))
      else
        file.write( URI.decode(data))
      end
    end
     
    csv
    
  end
  

  def csv
     file_name = 'temp.csv'
     @filename ="#{Rails.root}/public/uploads/#{file_name}"
     send_file(@filename ,
      :type => 'text/csv',
      :disposition => 'attachment')           
  end
end
