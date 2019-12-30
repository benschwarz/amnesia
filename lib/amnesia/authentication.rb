module Amnesia
  module Authentication
    def self.included app
      app.class_eval do
        use Rack::Auth::Basic, "Amnesia" do |username, password|
          user, pass = ENV['AMNESIA_CREDS'].split(':')
          username == user and password == pass
        end if ENV['AMNESIA_CREDS']
      end
    end
  end
end
