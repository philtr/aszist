class TicketMailer < ActionMailer::Base
  def agent_reply(comment)
    @body = comment.body
    @to = "#{comment.ticket.user} <#{comment.ticket.user.email}>"
    @from = "#{comment.user} <#{comment.user.email}>"
    mail(:to => @to, :from => @from, :subject => "Re: #{comment.ticket.subject}")
  end
end
