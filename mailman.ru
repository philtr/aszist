require ::File.expand_path('../config/environment',  __FILE__)

Mailman::Application.run do
  to "support+%token%@#{ ENV["MAILMAN_DOMAIN"] }", 'TicketReceiver#add_comment'
  to "support@#{ ENV["MAILMAN_DOMAIN"] }", 'TicketReceiver#create_ticket'
end
