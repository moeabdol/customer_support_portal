class UsersController < ApplicationController
  def index
    @users = User.order('created_at DESC').page(params[:page])
    authorize @users
  end

  def show
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    @tickets = @user.tickets.order('created_at DESC').page(params[:page])
    authorize @user
  end

  def agents
    @users = User.where(role: 'agent').order('created_at DESC').page(
      params[:page])
    authorize @users
  end

  def customers
    @users = User.where(role: 'customer').order('created_at DESC').page(
      params[:page])
    authorize @users
  end
end
