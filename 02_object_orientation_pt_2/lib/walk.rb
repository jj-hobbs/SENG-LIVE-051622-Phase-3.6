require 'pry'
require_relative './savable.rb'

class Walk < Savable
  attr_accessor :time

end


binding.pry