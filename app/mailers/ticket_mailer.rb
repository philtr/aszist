class TicketMailer < ActionMailer::Base
  add_template_helper ApplicationHelper

  def agent_reply(comment)
    @comment = comment
    @to = "#{@comment.ticket.user} <#{@comment.ticket.user.email}>"
    @from = "#{@comment.user} <#{@comment.user.email}>"
    @reply_to = "#{ENV["MAILMAN_USER"]}+#{comment.ticket.token}@#{ENV["MAILMAN_DOMAIN"]}"

    mail(to: @to, from: @from, subject: "Re: #{@comment.ticket.subject}", reply_to: @reply_to)
  end

  def notify_agent(ticket)
    @ticket = ticket
    @to = "#{@ticket.agent} <#{@ticket.agent.email}>"
    @from = "#{@ticket.user} <#{@ticket.user.email}>"
    @reply_to = "#{ENV["MAILMAN_USER"]}+#{@ticket.token}@#{ENV["MAILMAN_DOMAIN"]}"
    mail(:to => @to, :from => @from, :reply_to => @reply_to,
      :subject => "[aszist] #{@ticket.subject}")
  end
end
