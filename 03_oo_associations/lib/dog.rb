class Dog < Savable

  attr_accessor :name, :age, :breed, :image_url, :last_fed_at, :last_walked_at

  # dog is going to have many feedings, this is represented by a collection(arrays)
  # one to many relationship is called a 'has_many'
  # one object has many instances of another class

  def feedings 
    # the goal of feedings is going to be to look at all our feeding instances and return an array of only the ones that belong to the instance we are calling feedings on
    Feeding.all.select do |feeding| feeding.dog == self 
    end
  end

  def dog_walks # return an array of all the dog_walks belonging to self
    DogWalk.all.select do |dw| 
      dw.dog == self
    end 
  end

  def walks 
    dog_walks.map {|dw| dw.walk}
  end

  def walk
    DogWalk.create(
      dog: self,
      walk: Walk.new(time: Time.now)
    )
  end
  
  def feed # zoie.feed
    Feeding.create(time: Time.now, dog: self)
  end

  # print details about a dog (including the last walked at and last fed at times)
  def print
    puts
    puts self.name.green
    puts "  Age: #{self.age}"
    puts "  Breed: #{self.breed}"
    puts "  Image Url: #{self.image_url}"
    puts "  Last walked at: #{format_time(self.last_walked_at)}"
    puts "  Last fed at: #{format_time(self.last_fed_at)}"
    puts
  end


  private

  def formatted_name
    if self.last_fed_at.nil? && self.last_walked_at.nil?
      "#{self.name} (hungry and needs a walk)".red
    elsif self.last_fed_at.nil?
      "#{self.name} (hungry)".red
    elsif self.last_walked_at.nil?
      "#{self.name} (needs a walk)".red
    else
      self.name.green
    end
  end

  def format_time(time)
    time && time.strftime('%l:%M %p on %Y-%m-%d')
  end
end

