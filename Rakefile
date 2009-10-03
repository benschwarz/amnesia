require File.join(File.dirname(__FILE__), "amnesia")
require 'spec/rake/spectask'

namespace :db do
  task :connect do
    Amnesia::Application.new
  end
  
  desc "Auto migrate the database"
  task :migrate => :connect do
    DataMapper.auto_migrate!
  end
end

task :default => :spec

desc "Run RSpec test suite"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['-c', '--format specdoc']
  t.spec_files = FileList['spec/**/*_spec.rb']
end