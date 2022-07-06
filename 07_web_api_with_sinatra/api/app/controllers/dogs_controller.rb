class DogsController < ApplicationController


  get '/dogs' do 
    Dog.all.to_json
  end

end