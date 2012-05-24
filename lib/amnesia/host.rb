module Amnesia
  class Host
    def initialize(address)
      @address = address
    end
  
    def alive? 
      return true if connection.stats
    rescue Memcached::Error
      return false
    end
  
    def method_missing(method, *args)
      stats[method.to_s.to_sym].sum if stats.has_key? method.to_s.to_sym
    end
  
    def stats
      connection.stats[connection.stats.keys.first]
      connection.stats
    rescue Memcached::Error
      return {}
    end

    def address
      @address || @connection.servers.join(', ')
    end
  
    private
  
    def connection
      @connection ||= @address ? Memcached.new(@address) : Memcached.new
    end
  end
end
