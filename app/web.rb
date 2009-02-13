include Amnesia

helpers do
  include Helpers
end

get '/' do
  @hosts = Host.all
  erb :index
end

post '/hosts/create' do
  @host = Host.new(params[:host])
  if @host.save
   redirect url('/')
  else
    show :new
  end
end

delete '/hosts/:host/destroy' do
  @host = Host.get(params[:host])
  throw not_found unless @host
  @host.destroy
  redirect url('/')
end

get '/hosts/new' do
  erb :new
end

get '/hosts/:host' do
  @host = Host.get(params[:host])
  throw not_found unless @host
  erb :host
end

not_found do
  erb :not_found
end
  