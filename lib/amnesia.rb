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

    def initialize(app = nil, configuration = {})
      Amnesia.config = configuration
      # Heroku
      Amnesia.config[:hosts] ||= [ENV["MEMCACHE_SERVERS"]].flatten if ENV['MEMCACHE_SERVERS']
      # Default if nothing set
      Amnesia.config[:hosts] ||= ['127.0.0.1:11211']
      super()
    end

    use Rack::Auth::Basic, "Amnesia" do |username, password|
      user, pass = ENV['AMNESIA_CREDS'].split(':')
      username == user and password == pass
    end if ENV['AMNESIA_CREDS']

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
    end

    get '/' do
      @hosts = Amnesia.config[:hosts].map{|host| Amnesia::Host.new(host)}
      haml :index
    end

    get '/:host' do
      if known_host? params[:host]
        @host = Amnesia::Host.new(params[:host])
        haml :host
      else
        halt 404
      end
    end

    def known_host? host
      Amnesia.config[:hosts].include? params[:host]
    end
  end
end
