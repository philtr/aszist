class MailReceiver
  def add_comment(message, params)
    ticket = Ticket.find_by_token(params[:token])
    user = User.find_by_email(message.from)

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

    puts "  ---> Added comment to Ticket \##{ticket.id}: "
    puts "       From: #{user.name} <#{user.email}>"
    puts "       Subject: #{ticket.subject}\n"
  end

  def create_ticket(message, params)
    puts " ---> Looking for user with email #{message.from}"
    user = User.find_by_email(message.from)
    puts "      Found user: #{user.name} <#{user.email}>"

    if message.multipart?
      puts " ---> Message is multipart, grabbing the text part"
      body = message.text_part.body.to_s
    else
      puts " ---> Message is plain text, grabbing the body"
      body = message.body.to_s
    end


    puts " ---> Creating new Ticket"
    ticket = Ticket.new
    puts "      Ticket initialized"
    ticket.user = user
    puts "      Set user: #{ticket.user.name} <#{ticket.user.email}>"
    ticket.agent = User.default_agent
    puts "      Assign to default agent: #{ticket.agent.name} <#{ticket.agent.email}>"
    ticket.subject = message.subject
    puts "      Set subject: #{ticket.subject}"
    ticket.body = body
    puts "      Set the body."

    if ticket.save
      puts " ---> Successfully created Ticket \##{ticket.id}"
      puts "      From: #{user.name} <#{user.email}>"
      puts "      Subject: #{ticket.subject}"
    else
      puts " ---> Could not create Ticket."
    end
  end
end