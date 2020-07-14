class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[check_token]

  # This is an example of public access route
  def index
  end

  # This is an example user authenticated route
  def check_token
  end
end