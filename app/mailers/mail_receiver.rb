class MailReceiver
  def add_comment(message, params)
    ticket = Ticket.find_by_token(params[:token])
    user = User.find_by_email(message.from)

    return if ticket.nil? || user.nil?

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
    comment.body.split("\n").each do |line|
      puts "       #{line}"
    end
  end

  def create_ticket(message)
  end
end