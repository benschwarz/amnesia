module Amnesia
  module Routes
    def self.included app
      app.class_eval do
        get '/' do
          haml :index
        end

        get '/:address' do
          @host = find_host params[:address]
          @host ? haml(:host) : halt(404)
        end

        def find_host address
          @hosts.find { |h| h.address == address }
        end
      end
    end
  end
end
