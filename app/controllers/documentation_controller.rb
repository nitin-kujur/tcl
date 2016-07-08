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
end
