Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: "sessions" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  get '/single-sign-on/login-response-redirect', to: 'sso#login_response_redirect'
  get '/single-sign-on/signup-response-redirect', to: 'sso#signup_response_redirect'
  get '/check-token', to: 'home#check_token', as: 'check_token'

end
