require 'sinatra'
require 'dalli'
require 'gchart'
require 'haml'

$:<< File.dirname(__FILE__)

require 'amnesia/host'
require 'core_ext/array'

module Amnesia
  class << self
    attr_accessor :config
  end
  
  class Application < Sinatra::Base
    set :public, File.join(File.dirname(__FILE__), 'amnesia', 'public')
    set :views, File.join(File.dirname(__FILE__), 'amnesia', 'views')

    def initialize(app, configuration = {})
      Amnesia.config = configuration
      # Heroku
      Amnesia.config[:hosts] ||= [nil] if ENV['MEMCACHE_SERVERS']
      # Default if nothing set
      Amnesia.config[:hosts] ||= ['127.0.0.1:11211']
      super(app)
    end
    
    helpers do
      def graph_url(data = [])
        GChart.pie(:data => data, :size => '115x115').to_url
      end
      
      def number_to_human_size(size, precision=1)
        return '0' if size == 0
        units = %w{B KB MB GB TB}
        e = (Math.log(size)/Math.log(1024)).floor
        s = "%.#{precision}f" % (size.to_f / 1024**e)
        s.sub(/\.?0*$/, ' '+units[e])
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
    
    get '/amnesia' do
      protected!
      @hosts = Amnesia.config[:hosts].map{|host| Amnesia::Host.new(host)}
      haml :index
    end

    get '/amnesia/:host' do
      protected!
      @host = Amnesia::Host.new(params[:host])
      haml :host
    end
  end
end
