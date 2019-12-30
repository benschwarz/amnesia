Gem::Specification.new do |s|
  s.name        = "amnesia"
  s.version     = "1.0.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Schwarz"]
  s.email       = ["ben.schwarz@gmail.com"]
  s.homepage    = "http://github.com/benschwarz/amnesia"
  s.summary     = "Amnesia is what you get when you lose your memory"
  s.description = "With Amnesia you'll know exactly whats happening with memory when it comes to memcached."
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENCE README.markdown)
  s.require_path = 'lib'

  s.add_dependency "sinatra"
  s.add_dependency "dalli"
  s.add_dependency "googlecharts", "~> 1.6.8"
  s.add_dependency "haml"

  s.add_development_dependency "rspec", "~> 3.9"
  s.add_development_dependency "rack-test"
end
