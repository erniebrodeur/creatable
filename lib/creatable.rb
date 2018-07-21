require "creatable/version"

# include this, documentation will come.
module Creatable
  def attributes
    @attributes
  end

  def attribute(name: nil, type: nil, kind_of: nil)
    if ['accessor', 'reader'].include?(type)
      define_method name.to_s do
        instance_variable_get "@#{name}"
      end
    end

    if ['accessor', 'writer'].include?(type)
      define_method "#{name}=" do |value|
        raise ArgumentError, "parameter #{name} (#{value.class}) is not a kind of #{kind_of}" unless value.is_a?(kind_of) || value.nil?
        instance_variable_set "@#{name}", value
      end
    end

    @@attributes.push name.to_sym
  end

  def create(username: nil, password: nil, idle_timeout: nil, duration: nil, token: nil)
    object = new
    @@attributes.each { |l| object.send "#{l}=".to_sym, binding.local_variable_get(l) }
    object
  end
end
