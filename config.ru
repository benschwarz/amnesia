$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'bundler/setup'
require 'lib/amnesia'

use Amnesia::Application, :hosts => ['localhost:11211', 'localhost:0987']
run Sinatra::Application