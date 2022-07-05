class Dog < ActiveRecord::Base
  has_many :feedings 
  has_many :dog_walks 
  has_many :walks, through: :dog_walks # many to many 

  # means that we will get back a collection of associated feedings 

  # .feedings => return all the feedings associated with the instance it was called on i.e zoie.feedings
  # .feedings << new instance of feeding 
    # f = Feeding.create(time: Time.current)
    # zoie.feedings << f 

  # feedings.build() => another way to create a new feeding and associate it directly with the dog all in one step 
    # zoie.feedings.build(time: Time.current) caution: its not going to save it to the database, also need to call .save 
  
end