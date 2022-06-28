
require 'pry'
require_relative './savable.rb'
class Dog < Savable
  attr_accessor :name, :age, :breed, :image_url, :last_walked_at, :last_fed_at

  # {name: "archie"}

  # ✅ 1. class variable: all - holds all dogs we have saved

  # @variable_name > instance variable
  # @@variable_name => class variable 

  # @@all = []

  # # ✅ 2. class method: 'all' - retrieves the value of the class variable

  # # should this be a class method vs an instance method 
  # # if it is operating on the entire class, its going to be class method

  # def self.all # come back to this for more optimization
  #   @@all
  # end
  # # .all references a class method
  
  # # initialize with an optional hash of attributes
  # def initialize(attributes = {})
  #   attributes.each do |attribute, value|
  #     self.send("#{attribute}=", value)
  #   end
  # end
  

  # ✅ 3. instance method: '#save' - saves this dog instance to our class variable

  # def save 
  #   @@all << self
  #   self
  # end
  
  # # ✅ 4. class method: '.create' - creates a new instances and saves it to the class variable
  # def self.create(attributes = {})
  #   self.new(attributes).save
  # end

  # ✅ 5. instance method: 'walk' - updates the dog's last_walked_at property to the current time
  def walk 
    self.last_walked_at = Time.now
  end
  
  # ✅ 6. instance method: 'feed' - updates the dog's last_fed_at property to the current time
  def feed 
    self.last_fed_at = Time.now
  end

  # print details about a dog (including the last walked at and last fed at times)
  def print
    puts
    puts formatted_name
    puts "  Age: #{self.age}"
    puts "  Breed: #{self.breed}"
    puts "  Image Url: #{self.image_url}"
    puts "  Last walked at: #{format_time(self.last_walked_at)}"
    puts "  Last fed at: #{format_time(self.last_fed_at)}"
    puts
  end

  # private method: its a method that is not accessible outside of the class that its been defined in . 

  private

  # ✅ 7. private method: '#formatted_name' - returns the name of the dog color coded to indicate whether they are hungry or need a walk
  def formatted_name
    if self.last_fed_at.nil? && self.last_walked_at.nil?
      "#{self.name} hungry and needs a walk"
    elsif self.last_fed_at.nil? 
      "#{self.name} is hungry"
    elsif self.last_walked_at.nil?
      "#{self.name} needs a walk"
    else 
      self.name
    end
  end

  # ✅ 8. private method: '#format_time(time)' - accepts a time and returns it in a human readable format
  # should look like this: "Monday, 04/18/22 10:12 AM"
  def format_time(time)
    time && time.strftime('%l:%M %p on %Y-%m-%d')
  end

end

# this is how we invoke a class method 

archie = Dog.create({name: "archie", breed: "pug", age: 1, image_url: "image.com"})
binding.pry