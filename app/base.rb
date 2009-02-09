module Amnesia  
  class << self
    def new(config_file)
      self.config = config_file unless config_file.nil?
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
    
    def config=(file)
      @config ||= default_config.merge(YAML.load_file(file))
    end
  end
end