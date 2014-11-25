class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_person

  def current_person
    current_user.try!(:person)
  end

  def after_sign_in_path_for(resource)
    projects_path
  end

  def after_sign_out_path_for(resource)
    projects_path
  end

  def new_session_path(scope)
    projects_path
  end
end
