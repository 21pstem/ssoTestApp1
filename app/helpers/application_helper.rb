module ApplicationHelper
  def intercomponent_link(link_text, url)
    SSO_ENABLED ? link_to(link_text, url + "?jwt_token=#{session[:jwt_token]}") : link_to(link_text, url)
  end
end
