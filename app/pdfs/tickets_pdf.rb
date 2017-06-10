class TicketsPdf < Prawn::Document
  def initialize(user, tickets)
    super()
    @user = user
    @tickets = tickets.where(updated_at: 1.month.ago..Time.now).order(
      'created_at DESC')
    user_header
    line_items
  end

  def user_header
    text("#{@user.email}", size: 20, style: :bold)
    text("Resolved Tickets (#{@tickets.count})", size: 12)
    text("From: #{1.month.ago.strftime('%d/%m/%Y')} To: " +
      "#{Time.now.strftime('%d/%m/%Y')}")
  end

  def line_items
    move_down(10)
    table(line_items_rows, header: true, column_widths: {1=> 250},
      row_colors: ["F0F0F0", "FFFFCC"], cell_style: {
        inline_format: true,
        size: 11
      })
  end

  def line_items_rows
    pdf_table = [[ '<b>ID</b>', '<b>Ticket</b>', '<b>Created By</b>',
      '<b>Created At</b>', '<b>Resolved At</b>']]
    @tickets.each do |ticket|
      pdf_table << [
        ticket.id, ticket.content,
        ticket.users.select { |user| user.customer? }.first.email,
        ticket.created_at.strftime('%d/%m/%Y'),
        ticket.updated_at.strftime('%d/%m/%Y')
      ]
    end
    pdf_table
  end
end
