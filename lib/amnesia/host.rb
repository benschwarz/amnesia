require 'dalli'

module Amnesia
  class Host
    FLOAT_STATS  = %w[ rusage_user rusage_system ]
    STRING_STATS = %w[ version libevent ]

    def self.normalize_address address
      return "#{address}:#{Dalli::Server::DEFAULT_PORT}" unless address.include? ":"

      address
    end

    def initialize(address)
      @address = self.class.normalize_address address
    end

    def alive?
      return true if connection.stats[@address]
    rescue Dalli::DalliError
      return false
    end

    def method_missing(method, *args)
      if stats.has_key? method.to_s
        value = stats[method.to_s]
        if FLOAT_STATS.include? method
          Float(value)
        elsif STRING_STATS.include? method
          value
        else
          Integer(value)
        end
      else
        super
      end
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
