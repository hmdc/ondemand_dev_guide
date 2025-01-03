require 'sinatra'
require 'erubi'
require './command'

helpers do
  def dashboard_title
    "Open OnDemand"
  end

  def dashboard_url
    "/pun/sys/dashboard/"
  end

  def title
    "Passenger App Processes"
  end
end

get '/' do
  @command = Command.new
  @processes, @error = @command.exec

  # Render the view
  erb :index
end

get '/about' do
  @time = Time.now
  erb :about
end