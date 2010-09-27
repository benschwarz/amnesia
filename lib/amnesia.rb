require 'bundler/setup'
require 'sinatra'
require 'memcache'
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
      super(app)
    end
    
    helpers do
      def graph_url(data = [], labels = [])
        GChart.pie(data: data, size: '115x115').to_url
      end
    end
    
    get '/amnesia' do
      @hosts = Amnesia.config[:hosts].map{|host| Host.new(host)}
      haml :index
    end

    get '/amnesia/:host' do
      @host = Host.new(params[:host])
      haml :host
    end

    not_found do
      haml :not_found
    end
  end
end