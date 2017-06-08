class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
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
