# spec/app_spec.rb
require 'spec_helper'

RSpec.describe 'My Sinatra App' do
  it "loads the home page" do
    get '/', {}, { 'HTTP_HOST' => 'localhost', 'REMOTE_ADDR' => '127.0.0.1' }
    expect(last_response).to be_ok
    expect(last_response.body).to include("Passenger App Processes")
  end

  it "returns 404 for unknown routes" do
    get '/unknown', {}, { 'HTTP_HOST' => 'localhost', 'REMOTE_ADDR' => '127.0.0.1' }
    expect(last_response.status).to eq(404)
  end
end