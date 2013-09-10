class UsersController < ApplicationController

  include AuthEasy::RegistrationActions
  
  def show
    @user = User.find(params[:id])
    @total_graph = @user.graph_for_total_weight_over_time(1)
  end
end