require "creatable/version"
require 'creatable/instance_methods'

# Main module you include in your class
module Creatable
  # Override to load the ClassMethods
  # @param [Object] object
  # @return [Void]
  def self.included(object)
    object.extend InstanceMethods
  end

  # Returns the hash of built attributes
  # @return [Hash] the name, type, and kind_of built attributes.
  def attributes
    self.class.attributes
  end

  # Returns the names of the attributes.
  # @return [Array] list of names of the attributes
  def attribute_names
    self.class.attributes.map { |a| a[:name] }
  end

  # Returns the settings of all attributes.
  # @return [Hash] k/v pairs of the current class attributes
  def to_parameters
    h = {}
    attribute_names.each do |name|
      h.store name, instance_variable_get("@#{name}")
    end
    h
  end
end
