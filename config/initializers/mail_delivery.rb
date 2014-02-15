Aszist::Application.config.action_mailer.delivery_method = :smtp
Aszist::Application.config.action_mailer.smtp_settings = {
  address: ENV["SMTP_ADDRESS"],
  port: ENV["SMTP_PORT"],
  domain: ENV["SMTP_DOMAIN"],
  user_name: ENV["SMTP_USERNAME"],
  password: ENV["SMTP_PASSWORD"],
  authentication: ENV["SMTP_AUTHENTICATION"],
  enable_starttls_auto: [false, true][ENV["SMTP_ENABLE_STARTTLS"].to_i]
}

