require File.join(File.dirname(__FILE__), "amnesia")

namespace :db do
  task :connect do
    Amnesia.new
  end
  
  desc "Auto migrate the database"
  task :migrate => :connect do
    DataMapper.auto_migrate!
  end  
  
end