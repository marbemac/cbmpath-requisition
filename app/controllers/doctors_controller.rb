class DoctorsController < ApplicationController
  before_filter :authenticate_user!
  authorize_resource

  def search
    @doctors = current_user.doctors.where('searchable_name LIKE ?', "%#{params[:query].parameterize}%")
    render :json => {:query => params[:query], :suggestions => Doctor.to_search_json(@doctors)}
  end
end
