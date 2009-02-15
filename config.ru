require 'amnesia'

set :run, false
set :environment, :production
set :raise_errors, true

log = File.new("sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

run Amnesia.new