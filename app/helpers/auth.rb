module Amnesia
  module Helpers
    module Auth
      def protected!
        response['WWW-Authenticate'] = %(Basic realm="Amensia, statistics for Memcached") and \
        throw(:halt, [401, "Not authorized\n"]) and \
        return unless authorized?
      end

      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [Amnesia.config[:auth][:username], Amnesia.config[:auth][:password]]
      end
    end
  end
end