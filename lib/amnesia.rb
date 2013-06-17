require 'sinatra/base'
require 'googlecharts'
require 'haml'

$:<< File.dirname(__FILE__)

require 'amnesia/host'
require 'core_ext/array'

module Amnesia
  class << self
    attr_accessor :config
  end
  
  class Application < Sinatra::Base
    set :public_folder, File.join(File.dirname(__FILE__), 'amnesia', 'public')
    set :views, File.join(File.dirname(__FILE__), 'amnesia', 'views')

    def initialize(configuration = {})
      Amnesia.config = configuration
      # Heroku
      Amnesia.config[:hosts] ||= [ENV["MEMCACHE_SERVERS"]].flatten if ENV['MEMCACHE_SERVERS']
      # Default if nothing set
      Amnesia.config[:hosts] ||= ['127.0.0.1:11211']
      super()
    end
    
    helpers do
      def graph_url(data = [])
        Gchart.pie(:data => data, :size => '115x115')
      end
      
      def number_to_human_size(size, precision=1)
         size = Kernel.Float(size)
         case
           when size.to_i == 1;    "1 Byte"
           when size < 1.kilobyte; "%d Bytes" % size
           when size < 1.megabyte; "%.#{precision}f KB"  % (size / 1.0.kilobyte)
           when size < 1.gigabyte; "%.#{precision}f MB"  % (size / 1.0.megabyte)
           when size < 1.terabyte; "%.#{precision}f GB"  % (size / 1.0.gigabyte)
           else                    "%.#{precision}f TB"  % (size / 1.0.terabyte)
         end.sub(/([0-9])\.?0+ /, '\1 ' )
       rescue
         nil
       end

      def protected!
        unless authorized?
          response['WWW-Authenticate'] = %(Basic realm="Amnesia")
          throw(:halt, [401, "Not authorized\n"])
        end
      end

      def authorized?
        if ENV['AMNESIA_CREDS']
          @auth ||=  Rack::Auth::Basic::Request.new(request.env)
          @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ENV['AMNESIA_CREDS'].split(':')
        else
          # No auth needed.
          true
        end
      end
    end
    
    get '/' do
      protected!
      @hosts = Amnesia.config[:hosts].map{|host| Amnesia::Host.new(host)}
      haml :index
    end

    get '/:host' do
      protected!
      @host = Amnesia::Host.new(params[:host])
      haml :host
    end
  end
end
