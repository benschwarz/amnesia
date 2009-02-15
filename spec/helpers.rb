require 'base64'

module Amnesia
  module Spec
    module Helper
      def auth(method, path, params={})
        send(method, path, params, {'HTTP_AUTHORIZATION'=> encode_credentials})
      end
      
      private
      def encode_credentials
        "Basic " + Base64.encode64("#{Amnesia.config[:auth][:username]}:#{Amnesia.config[:auth][:password]}")
      end
    end
  end
end