require ::File.expand_path('../config/environment',  __FILE__)

Mailman::Application.run do
  to "#{ ENV["MAILMAN_USER"] }+%token%@#{ ENV["MAILMAN_DOMAIN"] }", 'TicketReceiver#add_comment'
  to "#{ ENV["MAILMAN_USER"] }@#{ ENV["MAILMAN_DOMAIN"] }", 'TicketReceiver#create_ticket'
end
