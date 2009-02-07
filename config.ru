require 'rubygems'
require 'sinatra'

set :run, false
set :environment, ENV['RACK_ENV']
set :raise_errors, true

root_dir = File.dirname(__FILE__)
$:.unshift "#{root_dir}/lib"
$:.unshift "#{root_dir}"
 
require 'amnesia'

run Amnesia.new('amnesia.yml')

Sinatra::Default.configure :development do
  DataMapper.auto_migrate!
end
