require ::File.expand_path('../config/environment',  __FILE__)

Mailman.config.pop3 = {
  :username => ENV["MAILMAN_USERNAME"],
  :password => ENV["MAILMAN_PASSWORD"],
  :server   => ENV["MAILMAN_SERVER"],
  :port     => ENV["MAILMAN_PORT"], # defaults to 110
  :ssl      => Proc.new { eval(ENV["MAILMAN_SSL"]) if ["true","false"].include? ENV["MAILMAN_SSL"] }
}

Mailman.config.poll_interval = 20

Mailman::Application.run do
  to "support+%token%@spt.la", 'MailReceiver#add_comment'
end
