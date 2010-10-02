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
      stats[method.to_s].to_i
    end
  
    def stats
      connection.stats[address]
    rescue Memcached::Error
      return {}
    end

    def address
      @address || @connection.servers.join(', ')
    end
  
    private
  
    def connection
      @connection ||= @address ? Dalli::Client.new(@address) : Memcached.new
    end
  end
end
