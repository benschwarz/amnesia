require File.dirname(__FILE__) + "amnesia"

namespace :db do
  task :connect
    Amnesia.new
  end
  
  desc "Auto migrate the database"
  task :migrate do
    DataMapper.auto_migrate!
  end  
  
end