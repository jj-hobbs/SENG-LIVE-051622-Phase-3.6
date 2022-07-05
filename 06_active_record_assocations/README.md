## 6. ActiveRecord Associations

### SWBAT

- [ ] Review domain modeling
- [ ] Review foreign vs primary keys
- [ ] Review rake and migrations
- [ ] Explain what macros are in Ruby classes
- [ ] Observe how to configure One to Many and Many to Many relationships using AR
- [ ] Observe using built in AR methods to access associated instances


### Deliverables

- create a `Feeding` class that inherits from `ActiveRecord::Base` 
- create a migration to make a `feedings` table with columns:
  - `time:datetime`
  - `dog_id:integer` (foreign key)
- add the `belongs_to` association so we can establish a 1-1 relationship between a Feeding and a Dog.
- add the `has_many` association to the Dog class to establish 1-many between dogs and feedings.
- create a `Walk` class that inherits from `ActiveRecord::Base`
- create a migration to make a `walks` table with columns:
  - `time:datetime`
- create a `DogWalk` class that inherits from `ActiveRecord::Base`
- create a migration to make a `dog_walks` table with columns:
  - `dog_id:integer`
  - `walk_id:integer`
- add the `belongs_to` relationship between `DogWalk` and `dog` and `walk` test in console
- add `has_many :dog_walks` to both the `Dog` and `Walk` classes.
- add a couple of `has_many, through` macros to `Dog` and `Walk` to establish many-to-many between the two models.
- create a walk that belongs to a dog by using the `walks.create` method to create a walk for a dog.
- assign multiple dogs to a walk using the `dog_ids=` method 
- use the `db/seeds.rb` file to create some seed data for the application
- after doing `rake db:seed:replant`, use the `rake console` to invoke and test association method:
  - `Dog.first.walks`
  - `Walk.first.dogs`
  - `Dog.first.feedings`



# Domain Modeling 

Dog 
- name, breed, birthdate, last_fed_at, last_walk, image_url
- has many dog_walks
- has many walks, through the dog_walks 
- has many feedings


DogWalk (join table) 
- belong to a dog => foreign key column: dog_id
- belong to a walk => foreign key col: walk_id


Walk 
- time:datetime
- has many dog_walks 
- has many dogs through dog_walks 

Feeding 
- time:datetime
- belong to dog: foreign key column => dog_id

- where do I need a foreign key: an id, a primary ID that refers to the record in another table that the object is related to through a belongs to relationship 
- Primary key columns: AR is going to handle this one for us, and its going to auto incrememnt per record that is  persisted 


# Association macros 
 
 - a macro this is a class method that creates instance methods 

 - belongs_to 
 - has_many
 - has_many :through 

 Feeding.create(time: Time, dog_id: 1) *****
 Feeding.create(time: Time, dog: Dog.first) => invoke .dog