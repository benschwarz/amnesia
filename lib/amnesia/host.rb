class Host
  attr_reader :address
  
  def initialize(address)
    @address = address
  end
  
  def alive? 
    return true if connection.stats
  rescue MemCache::MemCacheError
    return false
  end
  
  def method_missing(method, *args)
    return stats[method.to_s] if stats.has_key? method.to_s
  end
  
  def stats
    connection.stats[connection.stats.keys.first]
  rescue MemCache::MemCacheError
    return {}
  end
  
  private
  
  def connection
    @connection ||= MemCache.new(@address)
  end
end
