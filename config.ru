require 'amnesia'

set :run, false
set :environment, ENV['RACK_ENV']
set :raise_errors, true

run Amnesia.new