class Savable

  @@all = {}

  def self.new_from_row(row)
    row.transform_keys{|k| k.to_sym} # will convert string keys to symbols
  end

  def self.table_name
    self.name.tableize
  end

  def self.all
    @@all[self] ||= DOGS_DB.execute("SELECT * FROM #{self.table_name}").map do |row|
      self.new_from_row(row)
    end
  end

  def self.create(attributes = {})
    self.new(attributes).save
  end

  def initialize(attributes = {})
    attributes.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  def save
    self.class.all << self
    self
  end
end