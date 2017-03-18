class ActivitiesController < ApplicationController
  def index
  	if user_signed_in?
	    if current_user.role == "admin" 
	  		@activities = PublicActivity::Activity.order("created_at desc")
	  	else
	  		redirect_to root_path
        	flash[:alert] = "Sorry! You Cant Access The Page"
	  	end
  	end
  end
end
