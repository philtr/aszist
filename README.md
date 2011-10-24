# Aszist

Open-source helpdesk support system

## Getting Started

### Get the source code

```bash
git clone git://github.com/philtr/aszist.git
```

### Install gems

```bash
bundle install
```

### Load database schema

```bash
rake db:schema:load
```

### Set up Incoming email

Modify `config/mailman.yml` or set the following environment variables:

```bash
MAILMAN_USERNAME # POP3 username
MAILMAN_PASSWORD # POP3 password
MAILMAN_SERVER   # POP3 mail server name
MAILMAN_PORT     # probably '25'
MAILMAN_SSL      # use SSL? true/false

MAILMAN_POLL_INTERVAL # don't set this too low or your server might block you

MAILMAN_DOMAIN # support@MAILMAN_DOMAIN
```

### Start the servers

```bash
rails server
rackup mailman.ru
```

### Need more help?

Ask on the [mailing list](http://groups.google.com/group/aszist).

## Requirements

Rails 3.1.0

### Application Gems
* devise
* cancan
* hashie
* mailman
* mysql2
* paper_trail
* redcarpet
* simple_form
* sqlite3

### Asset template engines
* sass-rails
* coffee-script
* uglifier
* jquery-rails
* therubyracer
* mail_view

## License

Copyright &copy; 2011 Phillip Ridlen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
