class Walk < Savable
  attr_accessor :time


  # a walk has many dog_walks
  def dog_walks 
    DogWalk.all.select {|dw| dw.walk == self} 
  end

  # all the dogs a walk has through dog_walk 
  def dogs 
    dog_walks.map { |dw| dw.dog }
  end

end