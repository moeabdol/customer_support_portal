class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def show
    if params[:id].nil?
      @user = current_user
      @tickets = current_user.tickets
    else
      @user = User.find(params[:id])
      @tickets = @user.tickets
    end
    authorize @user
  end

  def agents
    @users = User.where(role: 'agent')
    authorize @users
  end

  def customers
    @users = User.where(role: 'customer')
    authorize @users
  end
end
