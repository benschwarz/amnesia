module Amnesia
  module Routes
    def self.included app
      app.class_eval do
        get '/' do
          haml :index
        end

        get '/pie' do
          data = params[:d].to_s.split(",").map(&:to_i)

          r = 25
          c = (2*Math::PI*r).ceil
          v = data.first.to_f / data.last * 100 * c / 100
          v = v.nan? ? 0 : v.ceil

          content_type "image/svg+xml"
          <<~BODY
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"
                 style="transform:rotate(-90deg);">
              <circle r="#{r*2}" cx="50" cy="50" fill="#FFEBCC" />
              <circle r="#{r}" cx="50" cy="50"
                fill="transparent" stroke="#FF9901"
                stroke-width="#{r*2}" stroke-dasharray="#{v} #{c}"
              />
            </svg>
          BODY
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
