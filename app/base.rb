module Amnesia
  def self.config
    @config ||= YAML.load_file("amnesia.yml")[Sinatra::Application.environment]
  end
  
  class Application < Sinatra::Base
    
    enable :static
    set :public, File.join(File.dirname(__FILE__), '..', 'public')    
    set :environment, :production
    set :raise_errors, true
    
    configure do
      DataMapper.setup(:default, Amnesia.config[:db])
    end
  
    helpers do
      include Amnesia::Helpers
    end

    before do
      protected! if Amnesia.config.has_key?(:auth)
    end

    get '/' do
      @hosts = Host.all
      erb :index
    end

    post '/hosts/create' do
      @host = Host.new(params[:host])
      if @host.save
       redirect url('/')
      else
        show :new
      end
    end

    delete '/hosts/:host/destroy' do
      @host = Host.get(params[:host])
      throw not_found unless @host
      @host.destroy
      redirect url('/')
    end

    get '/hosts/new' do
      erb :new
    end

    get '/hosts/:host' do
      @host = Host.get(params[:host])
      throw not_found unless @host
      erb :host
    end

    not_found do
      erb :not_found
    end
  end
end