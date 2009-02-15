require 'amnesia'

set :run, false
set :environment, :production
set :raise_errors, true

run Amnesia.new