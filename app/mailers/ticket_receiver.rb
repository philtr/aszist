class TicketReceiver
  def add_comment(message, params)
    ticket = Ticket.find_by_token(params[:token])
    user = User.find_by_email(message.from.first)

    return if ticket.nil? || user.nil?

    unless user.role?(:admin)
      return if (ticket.user != user) and (ticket.agent != user)
    end

    if message.multipart?
      body = message.text_part.body.to_s
    else
      body = message.body.to_s
    end

    comment = Comment.new
    comment.ticket = ticket
    comment.user = user
    comment.body = body
    comment.save

    Mailman.logger.info "  ---> Added comment to Ticket \##{ticket.id}: "
    Mailman.logger.info "       From: #{user.name} <#{user.email}>"
    Mailman.logger.info "       Subject: #{ticket.subject}\n"
  end

  def create_ticket(message, params)
    Mailman.logger.info " ---> Looking for user with email #{message.from.first}"
    user = User.where(email: message.from.first).first_or_create
    Mailman.logger.info "      Found user: #{user.name} <#{user.email}>"

    if message.multipart?
      Mailman.logger.info " ---> Message is multipart, grabbing the text part"
      body = message.text_part.body.to_s
    else
      Mailman.logger.info " ---> Message is plain text, grabbing the body"
      body = message.body.to_s
    end


    Mailman.logger.info " ---> Creating new Ticket"
    ticket = Ticket.new
    Mailman.logger.info "      Ticket initialized"
    ticket.user = user
    Mailman.logger.info "      Set user"
    agent = User.default_agent
    ticket.agent = agent
    Mailman.logger.info "      Assign to default agent: #{agent.name} <#{agent.email}>"
    ticket.subject = message.subject
    Mailman.logger.info "      Set subject: #{ticket.subject}"
    ticket.body = body
    Mailman.logger.info "      Set the body."

    if ticket.save
      Mailman.logger.info " ---> Successfully created Ticket \##{ticket.id}"
      Mailman.logger.info "      From: #{user.name} <#{user.email}>"
      Mailman.logger.info "      Subject: #{ticket.subject}"
    else
      Mailman.logger.info " ---> Could not create Ticket."
    end
  end
end
