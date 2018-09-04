module Creatable
  # Class methods that get mixed in.
  module ClassMethods
    # Returns the list of attributes attatched to this object
    # @return [Array] the current attributes
    def attributes
      @attributes ||= []
    end

    # TODO: new spec to cover the 'type' setting (including default).
    # TODO: new spec to assure kind_of behaves properly.
    # Replacement for attr_*   Will build the same getter/setter methods.
    # will also include a kind_of check.
    # @param [String] name name of the attribute
    # @param [String] type accessor, reader, or writer
    # @param [Class] kind_of class that this can be set too
    # @raise [ArgumentError] if name is not supplied
    # @raise [ArgumentError] if the type is not accessor, reader, or writer
    # @return [Void]
    def attribute(name: nil, type: 'accessor', kind_of: nil)
      raise ArgumentError, 'name is a required parameter' unless name
      raise ArgumentError, "type must be of type: 'accessor', 'reader', or 'writer'" unless ['accessor', 'reader', 'writer'].include? type

      if ['accessor', 'reader'].include?(type)
        define_method name.to_s do
          instance_variable_get "@#{name}"
        end
      end

      if ['accessor', 'writer'].include?(type)
        if kind_of.nil?
          define_method("#{name}=") { |value| instance_variable_set "@#{name}", value }
        else
          define_method("#{name}=") do |value|
            raise ArgumentError, "parameter #{name} (#{value.class}) is not a kind of (#{kind_of})" unless value.is_a?(kind_of) || value.nil?
            instance_variable_set "@#{name}", value
          end
        end
      end
      attributes.push(name: name, type: type, kind_of: kind_of)
      nil
    end

    # TODO: enhance tests here, around storing mulitple attributes.
    # Create a new instance of a given object.   Allows you to pass in any attribute.
    # @param [Hash] args key/value pairs for existing attributes
    # @return [Object] Newly created object
    def create(args = {})
      object = new
      names = attributes.map { |e| e[:name].to_sym }
      args.each do |k, v|
        object.instance_variable_set "@#{k}".to_sym, v if names.include? k
      end
      object
    end
  end
end
