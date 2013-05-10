class HomeController < ApplicationController

  def welcome
    if signed_in?
      redirect_to admin_requisition_forms_path
    end
  end

end
