require "creatable/version"
require 'creatable/class_methods'

# Main module you include in your class
module Creatable
  # Override to load the ClassMethods
  # @param [Object] object
  # @return [Void]
  def self.included(object)
    object.extend ClassMethods
  end

  # Returns the hash of built attributes
  # @return [Hash] the name, type, and kind_of built attributes.
  def attributes
    self.class.attributes
  end
end
