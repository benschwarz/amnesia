module Amnesia  
  class << self
    def new(config_file)
      self.config = config_file unless config_file.nil?
      DataMapper.setup(:default, config[:db])
      Sinatra::Application
    end
    
    def log(message)
      logger.info(message)
    end
    
    def config
      @config ||= default_config
    end
    
    private
    def logger
      @logger ||= Logger.new(config[:log])
    end
    
    def default_config
      @default ||= {
        :log => STDOUT,
        :db => 'sqlite3::memory:'
      }
    end
    
    def config=(file)
      @config ||= default_config.merge(YAML.load_file(file))
    end
  end
end