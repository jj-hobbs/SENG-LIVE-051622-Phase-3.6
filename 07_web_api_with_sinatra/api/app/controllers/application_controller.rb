class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  # this is where endpoints that have nothing to do with our models are going to be defined

  # root route: landing page 

  get "/" do 
    { hello: "world" }.to_json # serializing data into a JSON format
  end

end
