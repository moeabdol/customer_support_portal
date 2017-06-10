class UsersController < ApplicationController
  before_action :find_user, only: ['edit', 'update', 'destroy']

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

    respond_to do |format|
      format.html
      format.pdf do
        pdf = TicketsPdf.new(@user, @user.tickets)
        send_data(pdf.render, filename: 'resolved_tickets.pdf',
          type: 'application/pdf')
      end
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated successfully."
      redirect_to @user
    else
      flash.now[:danger] = "User was not updated."
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "User deleted successfully."
    redirect_to users_path
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

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end

  def find_user
    @user = User.find(params[:id])
    authorize @user
  end
end
