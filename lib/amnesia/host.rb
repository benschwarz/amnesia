module Amnesia
  class Host
    attr_reader :address
  
    def initialize(address)
      @address = address
    end
  
    def alive? 
      return true if connection.stats
    rescue Memcached::Error
      return false
    end
  
    def method_missing(method, *args)
      stats[method.to_s.to_sym][0] if stats.has_key? method.to_s.to_sym
    end
  
    def stats
      connection.stats[connection.stats.keys.first]
      connection.stats
    rescue Memcached::Error
      return {}
    end
  
    private
  
    def connection
      @connection ||= Memcached.new(@address)
    end
  end
end
