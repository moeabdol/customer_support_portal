class UsersController < ApplicationController
  def index
    @page = params[:page]
    if @page == 'agents'
      @users = User.where(role: 'agent')
    elsif @page == 'customers'
      @users = User.where(role: 'customer')
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
