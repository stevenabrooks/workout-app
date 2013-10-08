class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  
  protect_from_forgery

  def after_sign_in_path_for(resource)
    routines_path 
  end

  def after_sign_up_path_for(resource)
    routines_path
  end
  
end
