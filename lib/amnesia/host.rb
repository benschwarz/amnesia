require 'dalli'

module Amnesia
  class Host
    def initialize(address)
      @address = address
    end

    def alive?
      return true if connection.stats[@address]
    rescue Dalli::DalliError
      return false
    end

    def method_missing(method, *args)
      stats[method.to_s].sum if stats.has_key? method.to_s
    end

    def stats
      stats_val = connection.stats
      stats_val.values.first || {}
    end

    def address
      @address || @connection.servers.join(', ')
    end

    private

    def connection
      @connection ||= connect(@address)
    end

    def connect(address = nil)
      if defined?(EM) && EM.respond_to?(:reactor_running?) && EM::reactor_running?
        opts = {async: true}
      else
        opts = {}
      end
      Dalli::Client.new(address, opts)
    end

  end
end
