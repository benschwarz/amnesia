require 'sinatra/base'
require 'googlecharts'
require 'haml'

$:<< File.dirname(__FILE__)

require 'amnesia/host'
require 'amnesia/helpers'
require 'amnesia/routes'

module Amnesia
  class Application < Sinatra::Base
    include Amnesia::Helpers
    include Amnesia::Routes

    set :public_folder, File.join(File.dirname(__FILE__), 'amnesia', 'public')
    set :views, File.join(File.dirname(__FILE__), 'amnesia', 'views')

    def initialize(app = nil, options = {})
      @hosts = build_hosts options[:hosts] || ENV['MEMCACHE_SERVERS'] || '127.0.0.1:11211'
      super app
    end

    def build_hosts addresses
      addresses = addresses.split "," if addresses.is_a? String
      Array(addresses).flatten.map { |address| Amnesia::Host.new address }
    end

    use Rack::Auth::Basic, "Amnesia" do |username, password|
      user, pass = ENV['AMNESIA_CREDS'].split(':')
      username == user and password == pass
    end if ENV['AMNESIA_CREDS']
  end
end
