class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def agents
    @users = User.where(role: 'agent')
  end

  def customers
    @users = User.where(role: 'customer')
  end
end
