class TicketMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  def agent_reply(comment)
    @comment = comment
    @to = "#{@comment.ticket.user} <#{@comment.ticket.user.email}>"
    @from = "#{@comment.user} <#{@comment.user.email}>"
    mail(:to => @to, :from => @from, :subject => "Re: #{@comment.ticket.subject}")
  end

  def receive(message, params)
    if params[:token]
      ticket = Ticket.find_by_token(params[:token])
      user = User.find_by_email(message[:from])
      ticket.comments.create(:user => user, :body => message[:body])
    else
      # Create new User
      # Create new Ticket
      # Notify necessary parties
    end
  end
end
