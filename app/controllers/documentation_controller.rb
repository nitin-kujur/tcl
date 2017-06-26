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
    require 'open-uri'

    path = File.join Rails.root, 'public', 'uploads'

    FileUtils.mkdir_p(path) unless File.exist?(path) 
    open(File.join(path, 'temp.cs'), 'wb') do |file|
      file << open(params[:file_data]).read
    end
    # begin
    #   send_file 'temp.csv'
    # rescue
      # csv
    # end
  end
  

  def csv
     file_name = 'temp.csv'
     @filename ="#{Rails.root}/public/uploads/#{file_name}"
     send_file(@filename ,
      :type => 'text/csv',
      :disposition => 'attachment')           
  end
end
