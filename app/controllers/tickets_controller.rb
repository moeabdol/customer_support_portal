class TicketsController < ApplicationController
  before_action :find_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all.order('created_at DESC')
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket
    else
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit(:content, :status)
  end

  def find_ticket
    @ticket = Ticket.find(params[:id])
  end
end
