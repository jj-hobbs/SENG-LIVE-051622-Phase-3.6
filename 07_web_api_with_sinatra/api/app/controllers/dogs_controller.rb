class DogsController < ApplicationController


  # create a route that returns a response of all dogs 
  # index: this is a path that will return the collcetion of a resource 

  get '/dogs' do 
    binding.pry
    # dogs = Dog.all
    # dogs.to_json
    Dog.all.to_json
  end

  # follow REST conventions to create and define our endpoints 



  # create a dynamic route that responds with a single dog given the ID parameter 
  # how is the id supplied
  # how do we access the ID 
  # params: we can receive params through a dynamic route, or any data that was submitted through a form

  get '/dogs/:id' do 
    dog = Dog.find(params[:id])
    dog.to_json
  end

end