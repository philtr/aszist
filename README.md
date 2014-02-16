# [![Aszist](http://aszist.s3.amazonaws.com/logo/aszist_med.png)](http://philtr.github.io/aszist/)

[![Build Status](https://travis-ci.org/philtr/aszist.png?branch=master)](https://travis-ci.org/philtr/aszist)

Open-source helpdesk support system

## Getting Started

### Get the source code

```bash
git clone git://github.com/philtr/aszist.git
cd aszist
```

### Install gems

```bash
bundle install
```

### Set up

```bash
rake setup
```

### Set environment configuration Mailman

```bash
cp env.sample .env
```

### Start the servers

Aszist uses a
[`Procfile`](https://github.com/philtr/aszist/blob/master/Procfile) to manage
processes, so use [Foreman](http://ddollar.github.com/foreman/) crank it up:

```bash
foreman start
```

If you want to crank up the servers individually or with Pow:

```bash
# Pow will only start the rails server
cd ~/.pow
ln -s path/to/aszist

# Rails server
rails server

# Mailman server
rackup mailman.ru
```

### Need more help?

Ask on the [mailing list](http://groups.google.com/group/aszist).

## Requirements

* Ruby (tsted on 2.1.0, 2.0.0, or 1.9.3)
* Bundler (1.5.3)
* PostgreSQL

All gem dependencies are listed in [`Gemfile.lock`](https://github.com/philtr/aszist/blob/master/Gemfile.lock)

## Contributing to Aszist

* Check out the latest master to make sure the feature hasn't been implemented
  or the bug hasn't been fixed yet
* Check out the [issue tracker](http://github.com/philtr/aszist/issues) to make
  sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for the feature/bugfix. This is important so I don't
  break it in a future version unintentionally.

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
