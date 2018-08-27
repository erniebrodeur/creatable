require "creatable/version"
require 'creatable/class_methods'

# include this, documentation will come.
module Creatable
  def self.included(object)
    object.extend ClassMethods
  end

  def attributes
    self.class.attributes
  end
end
