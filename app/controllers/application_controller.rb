class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def has_access_to_edit?
    !current_user.nil? && current_user.person_id == params[:id].to_i
  end

  def login_required
    if !has_access_to_edit?
      redirect_to('/')
      flash[:danger] = "You must be logged in to view this page."
    end
  end
end
