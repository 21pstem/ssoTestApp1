class SessionsController < Devise::SessionsController

  def create
  #   puts "asddsadsasdassdasdads"
  #   puts auth_options.inspect
    
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message!(:notice, :signed_in)
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   respond_with resource, location: after_sign_in_path_for(resource)

  
    body = { email: params[:user][:email], password: params[:user][:password]}
    response = HTTParty.post('http://localhost:3000/users/sign_in', body: body).parsed_response
    session[:jwt_token] = response['token']



  end

end