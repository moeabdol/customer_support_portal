module ApplicationHelper
  def active_class(name)
    controller_name.eql?(name) || current_page?(name) ? 'active' : ''
  end

  def ticket_status_class(ticket)
    ticket.status.eql?('resolved') ? 'success' : 'danger'
  end
end
