class Walk < ActiveRecord::Base 
  has_many :dog_walks 
  has_many :dogs, through: :dog_walks 

  # has many through shares the same set of methods given by the has many macro 

  #.dogs 
  # .dogs << 

end