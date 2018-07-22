class HomeController < ApplicationController
  def home_page
    if current_user
      redirect_to user_dashboard_url
    else
      redirect_to new_user_session_url
    end
  end
end
