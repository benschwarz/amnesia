require 'spec_helper'

describe Amnesia::Application do
  context "unauthenticated" do
    it "responds with 401 to get" do
      get '/'
      expect(last_response.status).to eq 401
    end
  end

  context "authenticated" do
    before(:each) do
      basic_authorize "admin", "amnesia"
    end

    let(:host) { Amnesia::Host.new("memcache") }

    it "should respond to root" do
      get '/'
      expect(last_response.status).to eq 200
    end

    it "should respond to /:host" do
      get "/127.0.0.1:11211"
      expect(last_response.status).to eq 200
    end

    it "should not display unknown host" do
      get "/unknown-host"
      expect(last_response.status).to eq 404
    end

    it "should not delete host" do
      delete "/unknown-host/destroy"
      expect(last_response.status).to eq 404
    end
  end
end
