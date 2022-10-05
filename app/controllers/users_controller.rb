class UsersController < ApplicationController

  def index 
    user = User.all 
    render json: user, include: :items 
  end 

  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  end

end
