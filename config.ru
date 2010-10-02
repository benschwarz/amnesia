$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'bundler/setup'
require 'lib/amnesia'

# This stops invalid US-ASCII characters on heroku.
if defined? Encoding
  Encoding.default_internal = 'utf-8' 
  Encoding.default_external = 'utf-8'
end

use Amnesia::Application # optional config: , :hosts => ['localhost:11211', 'localhost:0987']
run Sinatra::Application
