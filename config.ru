$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'bundler/setup'
require 'lib/amnesia'

# This stops invalid US-ASCII characters on heroku.
Encoding.default_internal = 'utf-8'
Encoding.default_external = 'utf-8'

use Amnesia::Application, hosts: ['localhost:11211', 'example.local:10987']
run Sinatra::Application
