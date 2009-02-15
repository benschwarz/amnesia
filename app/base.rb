module Amnesia  
  class << self
    def new(config_path = 'amnesia.yml')
      @config_path = config_path
      DataMapper.setup(:default, config[:db])
      Sinatra::Application
    end
    
    def config
      @config ||= YAML.load_file(@config_path)[Sinatra::Application.environment]
    end
  end
end