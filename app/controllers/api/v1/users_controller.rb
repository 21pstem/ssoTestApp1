class Api::V1::UsersController < ApplicationController
  respond_to :json

  def handle_sync_password
    puts 'THIS FIRES'
    status = update_user_password
    render json: {success: status}, status: status ? :ok : :unprocessable_entity
  end

  def decoded_token
    if request.headers['Authorization']
      token = request.headers['Authorization']
      begin
        token_data = JWT.decode(token, JWT_PASSWORD, true, algorithm: 'HS256')
        token_data[0]
      rescue JWT::DecodeError
        nil
      end
    end
  end

  private

  def update_user_password
    user = User.find_by_email(decoded_token['email'])
    if user.nil?
      User.create(email: decoded_token['email'], password: decoded_token['password'], password_confirmation: decoded_token['password'])
    else
      user.password = decoded_token['password']
      user.password_confirmation = decoded_token['password']
      user.save!
    end
  end
end