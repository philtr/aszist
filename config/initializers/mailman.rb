Mailman.config.logger = Rails.logger

server_config = {
  server:     ENV["MAILMAN_SERVER"],
  username:   ENV["MAILMAN_USERNAME"],
  password:   ENV["MAILMAN_PASSWORD"],
  port:       ENV["MAILMAN_PORT"].presence || 993,
  ssl:        ENV["MAILMAN_SSL"].presence || true
}

Mailman.config.send(ENV["MAILMAN_PROTOCOL"].downcase + "=", server_config)
Mailman.config.poll_interval = (ENV["MAILMAN_POLL_INTERVAL"] || 60).to_i

