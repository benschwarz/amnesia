module Amnesia
  module Helpers 
    module Url
      def url(path)
        url = "#{request.scheme}://#{request.host}"

        if request.scheme == "https" && request.port != 443 ||
          request.scheme == "http" && request.port != 80
          url << ":#{request.port}"
        end

        url << "/" unless path.index("/").zero?
        url << path
      end
    end
  end
end