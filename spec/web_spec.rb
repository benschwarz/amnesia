require File.join(File.dirname(__FILE__), 'env')

describe "HTTP Auth" do
  it "should require auth" do
    get '/'
    @response.status.should == 401
  end
  
  it "should auth successfully" do
    auth(:get, '/')
    @response.status.should == 200
  end
end

describe "response to paths" do
  
  describe 'successful' do
    it "should respond to root" do
      auth(:get, '/')
      @response.status.should == 200
    end
    
    it "should respond to /hosts/new" do
      auth(:get, "/hosts/new")
      @response.status.should == 200
    end
    
    it "should respond to /hosts/num" do
      host = Host.gen
      
      auth(:get, "/hosts/#{host.id}")
      @response.status.should == 200
    end
  end
  
  describe 'not found' do
    it "should not display host" do
      auth(:get, "/hosts/-1")
      @response.status.should == 404
    end
    
    it "should not delete host" do
      auth(:delete, "/hosts/-1/destroy")
      @response.status.should == 404
    end
  end
end