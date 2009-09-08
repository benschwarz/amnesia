Dir["#{File.dirname(__FILE__)}/helpers/*.rb"].each{|r| require r}

module Amnesia
  module Helpers
    include Auth
    include Url
    include Number
    include HostGraph
    
    include Rack::Utils
    alias :h :escape_html
  end
end