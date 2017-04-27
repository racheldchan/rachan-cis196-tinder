require 'pry'

class WelcomeController < ApplicationController
  def index
  	if logged_in?
  		users = User.where.not(id: current_user.id)
    	@current_profile = users.sample
	end
  end
end
