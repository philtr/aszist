source 'http://rubygems.org'

gem 'rails', '~> 3.1.1'

gem 'mailman', :git => 'git://github.com/titanous/mailman.git',
               :ref => '70382c3c32bde0c6e225bee39bea17af7cdfe39a'

# Application gems
gem 'devise', '~> 1.4.2'
gem 'cancan', '~> 1.6.5'
gem 'hashie', '~> 1.1.0'
gem 'paper_trail', '~> 2.2.9'
gem 'redcarpet', '~> 2.0.0b3'
gem 'simple_form', '~> 1.4.2'

# Asset template engines
gem 'sass-rails', '~> 3.1.0'
gem 'coffee-script', '~> 2.2.0'
gem 'uglifier', '~> 1.0.0'

gem 'jquery-rails', '~> 1.0.12'
gem 'therubyracer', '~> 0.9.2' # for execjs support

group :development do
  gem 'sqlite3', '~> 1.3.4'
  gem 'foreman'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'mysql2', '~> 0.3.7' 
end
