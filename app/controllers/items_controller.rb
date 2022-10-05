class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items 
    else
      items = Item.all 
    end 
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item 
  end

  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response(exception)
    render json: { error: "user not found" }, status: :not_found
  end
  
end
