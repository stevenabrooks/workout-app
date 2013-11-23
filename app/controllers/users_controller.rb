class UsersController < ApplicationController
  
  def show
    @user = User.includes(:routines => {:lifts => [:exercise, :infos]}).find(current_user.id)
    @total_graph = @user.graph_for_total_weight_over_time(1)
  end
end

# c = User.includes(:routines => {:lifts => [:exercise, :infos]}).find(current_user.id)

# t = User.includes(:routines => {:lifts => [:exercise, :infos]}).find(1)