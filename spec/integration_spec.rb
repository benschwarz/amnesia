require File.join(File.dirname(__FILE__), 'env')

describe "Existing hosts" do
  before do
    Host.gen(:local)
  end
  
  describe "/ (index)" do
    it "should list the host" do
      auth(:get, '/')
      puts @response.body
    end
  end
end