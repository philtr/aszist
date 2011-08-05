require ::File.expand_path('../config/environment',  __FILE__)

config = Hashie::Mash.new(YAML::load(ERB.new(File.read('config/mailman.yml')).result))

Mailman.config.logger = Logger.new(config.logger.logfile) if config.logger.use_logfile

Mailman.config.pop3 = {
  :username => config.pop3.username,
  :password => config.pop3.password,
  :server   => config.pop3.server,
  :port     => config.pop3.port, # defaults to 110
  :ssl      => config.pop3.ssl
}

Mailman.config.poll_interval = config.poll_interval

Mailman::Application.run do
  to "#{config.email.support.user}+%token%@#{config.email.support.domain}", 'MailReceiver#add_comment'
end
