require 'pry'
require_relative './dogs_data.rb'

class Dog
  #macro: a macro is a class method that creates instance methods
  # attr_accessor: gives us both a setter and getter method in one single line
  attr_accessor :name, :age, :breed

  # attr_reader: which will only create the getter method 
  # attr_writer: which will only create the setter method

  # ✅ we should be able to create dogs with a name, age, breed, and image_url

  # going to be automatically called when the .new method is invoked
  # this method sets all the rules upon creating an instance
  # def initialize(name, age, breed)
  #   @name = name  # here we are creating an instance variable
  #   @age = age
  #   @breed = breed
  # end

  # mass assignment: allows us to pass in a hash and then create the properties based on the keys in the hash
  # when we call .new, we need to pass in a hash
  # when we iterate over a key using a method like .each we are going to work with 2 values, key and value
  def initialize(attributes = {}) # this is an instance method being calle on the new created instance
    attributes.each do |attr, value| # block variables only accessible between the do and end
      self.send("#{attr}=", value)# invoking on the setter method to set the value 
      # self: here referes the instnce this method is being called on
    end
  end





  # # getter method/ reader method 
  # def name # instance method: this method can only be called on an instance
  #   # calling upon our instance through an impilicit self 
  #   # self is always going to refer to the receiver of the method 
  #   @name
  # end

  # # setter method/ writer method 

  # def name=(name)
  #   @name = name 
  # end

  

  # ✅ we want to be able to access a dog's name, age, breed, image_url, last_fed_at and last_walked at times



  # ✅ we want to be able to print details about a dog (this time including the last walked at and last fed at times)


end

binding.pry
