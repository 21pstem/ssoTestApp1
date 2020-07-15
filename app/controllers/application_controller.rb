class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_token_data
  before_action :verify_token


  def verify_token
    return true if is_valid_token?

    unless @payload.nil?
      user = User.find_by_email @payload['email']
      sign_out user if current_user.present? && user == current_user
    end

    false
  end

  def is_valid_token?
    return false if session[:jwt_token].nil?

    return false if @payload['invalid'].present?

    @payload['expires_at'] > Time.now
  end

  def set_token_data
    begin
      token_data = JWT.decode(session[:jwt_token], JWT_PASSWORD, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      token_data = nil
    end

    @payload = token_data.nil? ? nil : token_data[0]
    puts @payload.inspect
  end

  def after_sign_in_path_for(resource)
    check_token_path
  end
end
