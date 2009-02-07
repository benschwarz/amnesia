Dir["#{File.dirname(__FILE__)}/helpers/*.rb"].each &method(:require)

module Amnesia
  module Helpers
    include Url
    include Number
    include HostGraph
    
    include Rack::Utils
    alias :h :escape_html
  end
end