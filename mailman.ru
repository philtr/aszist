require ::File.expand_path('../config/environment',  __FILE__)

Mailman.config.pop3 = {
  :username => ENV["MAILMAN_USERNAME"],
  :password => ENV["MAILMAN_PASSWORD"],
  :server   => ENV["MAILMAN_SERVER"],
  :port     => ENV["MAILMAN_PORT"], # defaults to 110
  :ssl      => Proc.new { eval(ENV["MAILMAN_SSL"]) if ["true","false"].include? ENV["MAILMAN_SSL"] }
}

Mailman::Application.run do
  to "support+%token%@spt.la" do
    ticket = Ticket.find_by_token(params[:token])
    puts "Found ticket with token #{ticket.token}"
    user = User.find_by_email(message.from)
    puts "Found user for #{message.from}"


    if message.multipart?
      mail.parts.each do |part|
        body = part.body.decoded if part.type == 'text/plain'
      end
    else
      body = message.body.decoded
    end

    ticket.comments.new
    ticket.user = user
    ticket.body = message.from
    ticket.save
  end
end