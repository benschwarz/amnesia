require 'rubygems'
require 'bundler/setup'
require 'amnesia'

# This stops invalid US-ASCII characters on heroku.
Encoding.default_internal = 'utf-8'
Encoding.default_external = 'utf-8'

use Amnesia::Application, hosts: ['localhost', 'example.local:10987']
run Sinatra::Application
