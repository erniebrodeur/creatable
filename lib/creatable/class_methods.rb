module Creatable
  module ClassMethods
    def attributes
      @attributes ||= []
      @attributes
    end

    def attribute(name: nil, type: nil, kind_of: nil)
      type ||= 'accessor'
      raise ArgumentError, 'name is a required parameter' unless name
      raise ArgumentError, "type must be of type: 'accessor', 'reader', or 'writer'" unless ['accessor', 'reader', 'writer'].include? type

      if ['accessor', 'reader'].include?(type)
        define_method name.to_s do
          instance_variable_get "@#{name}"
        end
      end

      if ['accessor', 'writer'].include?(type)
        if kind_of.nil?
          define_method "#{name}=" do |value|
            instance_variable_set "@#{name}", value
          end
        else
          define_method "#{name}=" do |value|
            raise ArgumentError, "parameter #{name} (#{value.class}) is not a kind of (#{kind_of})" unless value.is_a?(kind_of) || value.nil?
            instance_variable_set "@#{name}", value
          end
        end
      end

      attributes.push name.to_sym
    end

    def create(args = {})
      object = new
      attributes.each { |l| object.send "#{l}=".to_sym, args[l] }
      object
    end
  end
end
