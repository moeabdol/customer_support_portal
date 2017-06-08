class TicketsController < ApplicationController
  before_action :find_ticket, only: [:show, :edit, :update, :destroy, :resolve]

  def index
    @tickets = Ticket.order('created_at DESC').page(params[:page])
    authorize @tickets
  end

  def new
    @ticket = Ticket.new
    authorize @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    authorize @ticket
    @ticket.users << current_user
    if @ticket.save
      flash[:success] = "Ticket created successfully."
      redirect_to @ticket
    else
      flash.now[:danger] = "Ticket was not created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = "Ticket updated successfully."
      redirect_to @ticket
    else
      flash.now[:danger] = "Ticket was not updated."
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    flash[:success] = "Ticket deleted successfully."
    redirect_to tickets_path
  end

  def resolve
    @ticket.update(status: 'resolved')
    @ticket.users << current_user
    redirect_to @ticket
  end

  private

  def ticket_params
    params.require(:ticket).permit(:content, :status)
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
    authorize @ticket
  end
end
