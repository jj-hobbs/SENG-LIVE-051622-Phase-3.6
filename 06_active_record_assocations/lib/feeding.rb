class Feeding < ActiveRecord::Base # library that supplies model dependent methods
  belongs_to :dog # one to one relationship

  # reader 

  # .dog => will return the dog instance that the feeding belongs to 

  # writer 

  # .dog => set the dog that the feeding belongs to i.e feeding.dog = zoie

  # build_dog(dog attributes) => create a new dog instance, associate it with the feeding we are calling this method on at the same time BUT its not going to persist it, we would have to call .save after 

  # create_dog(dog attributes) create a new dog instance, associate it wiht the feeding and persist to the database
end