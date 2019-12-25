require 'rspec'

ENV['RACK_ENV'] ||= 'test'
ENV['AMNESIA_CREDS'] ||= 'admin:amnesia'

require 'rack/test'
require 'amnesia'

module TestedApp
  include Rack::Test::Methods

  def app
    Amnesia::Application.new
  end
end

RSpec.configure do |rspec|
  rspec.include TestedApp
end
