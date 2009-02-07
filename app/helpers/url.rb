module Amnesia
  module Helpers 
    module Url
      def path_for(klass_instance, *args)
        "/" << [klass_instance.id, *args].join("/")
      end
  
      def url_for(klass_instance, *args)
        url(path_for(klass_instance, args))
      end
  
      # Thanks, integrity
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