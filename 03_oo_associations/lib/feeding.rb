class Feeding < Savable
  attr_accessor :dog, :time # gives us both a reader and writer method 
  

  # associate every new feeding to a dog by a one to one relationship 
  # belongs_to relationship: a feeding belongs to a dog
  # the method is going to be singular
  # when we are setting the dog value, its set to an instance of dog

  # when we create a new feeding, we want to let it know which dog this feeding belongs to

  # we need a setter method that will set the feedings dog attribute to an instance of a dog

  # def dog=(dog)
  #   @dog = dog
  # end

  # def dog 
  #   @dog
  # end


end