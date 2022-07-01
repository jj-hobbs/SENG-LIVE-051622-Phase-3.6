MVC 
- model: business logic of our application
  => classes
- view => replaced by react 
- controller

# configuring our app to use AR 

- install the AR gem 

# extend the methods supplied by AR to our classes 



# Create a migration file 
- a migration files purpose is to setup and manage our database tables
- command to use for creating a migration file : rake db:create_migration NAME
- i.e. we are going to create a migration file that sets up a dogs table. NAME=create_dogs
- i.e we want to add a new column to the dogs table: NAME=add_breed_to_dogs


### deliverable 1: create a table for our Dog model 
1. create a migration file by running rake db:create_migration NAME=create_dogs
2. ```ruby
  def change
    create_table :dogs do |t| # type of data stored in the column
      t.string :name 
      t.datetime :birthdate
      t.string :breed
    end
  end
  ```
3. Once we are ready to create the table we run `rake db:migrate`
  - it is going to run all our migration files in order given the timestamp