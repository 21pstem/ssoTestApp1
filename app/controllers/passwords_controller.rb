class PasswordsController < Devise::PasswordsController
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      update_sso_password(self.resource.email) if SSO_ENABLED

      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_database_authentication
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      respond_with resource
    end
  end

  def update_sso_password(email)
    body = { user: { email: email, password: params[:user][:password] } }
    token = JWT.encode({email: email}, JWT_PASSWORD)
    response = HTTParty.put('http://localhost:3000/users/password', body: body, headers: sso_headers(token)).parsed_response
    response['status']
  end
end