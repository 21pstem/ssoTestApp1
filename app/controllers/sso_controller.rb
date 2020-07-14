class SsoController < ApplicationController
  def login_response_redirect
    if params[:token]

    elsif params[:error]
    else

    end
  end

  def signup_response_redirect
    if params[:token]
    elsif params[:error]
    else

    end
  end
end