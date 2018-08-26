require "creatable/version"
require 'creatable/class_methods'

# include this, documentation will come.
module Creatable
  def self.included(o)
    o.extend ClassMethods
  end
end