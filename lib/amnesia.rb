require 'sinatra/base'
require 'googlecharts'
require 'haml'

$:<< File.dirname(__FILE__)

require 'amnesia/authentication'
require 'amnesia/helpers'
require 'amnesia/host'
require 'amnesia/routes'

module Amnesia
  class Application < Sinatra::Base
    include Amnesia::Authentication
    include Amnesia::Helpers
    include Amnesia::Routes

    set :public_folder, File.join(__dir__, 'amnesia', 'public')
    set :views, File.join(__dir__, 'amnesia', 'views')

    def initialize(app = nil, options = {})
      @hosts = build_hosts options[:hosts] || ENV['MEMCACHE_SERVERS'] || '127.0.0.1:11211'
      super app
    end

    def build_hosts addresses
      addresses = addresses.split "," if addresses.is_a? String
      Array(addresses).flatten.map { |address| Amnesia::Host.new address }
    end
  end
end
