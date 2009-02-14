module Amnesia  
  class << self
    def new
      configure!
      DataMapper.setup(:default, config[:db])
      Sinatra::Application
    end
    
    def config
      @config ||= default_config
    end
    
    private
    
    def default_config
      @default ||= {
        :db => 'sqlite3::memory:'
      }
    end
    
    def configure!
      @config ||= default_config.merge(YAML.load_file('amnesia.yml'))
    end
  end
end