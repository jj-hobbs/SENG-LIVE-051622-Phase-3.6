class Dog < ActiveRecord::Base
  # dog is a model 
  # a model is the part of our application that is concerend with all business logic regarding our applciations data
  # this means this is where we shape how the data in our app is going to look like 
  # this is the part that is going to communicate with the database!! 
end


# create a new dog record and store it in our database

# .new + .save => will make sure that the record is persisted to the db

# .create => instantiate and save to the db 


# read our data from the db 

# .all => return all the records in the db AS ruby objects

# update data from the db 

# combo of our setter method and .save

# .update(pass in the attribute we are updating)

