class Savable 
  @@all = []

  def self.all # come back to this for more optimization
    @@all
  end

  def initialize(attributes = {})
    attributes.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def save 
    @@all << self
    self
  end

  def self.create(attributes = {})
    self.new(attributes).save
  end
end