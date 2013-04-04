class HomeController < ApplicationController

  def welcome
    if signed_in?
      redirect_to user_path(current_user)
    end
  end

end
