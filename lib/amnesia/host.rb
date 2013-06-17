require 'dalli'

module Amnesia
  class Host
    def initialize(address)
      @address = address
    end
  
    def alive? 
      return true if connection.stats
    rescue Dalli::DalliError
      return false
    end
  
    def method_missing(method, *args)
      stats[method.to_s.to_sym].sum if stats.has_key? method.to_s.to_sym
    end
  
    def stats
      stats_val = connection.stats
      stats_val[stats_val.keys.first]
      stats_val
    rescue Memcached::Error
      return {}
    end

    def address
      @address || @connection.servers.join(', ')
    end
  
    private
  
    def connection
      @connection ||= @address ? Dalli::Client.new(@address) : Dalli::Client.new
    end
  end
end
