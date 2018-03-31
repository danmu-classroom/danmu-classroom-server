# abstract class
module Line
  module Format
    class Base
      attr_accessor :type

      def initialize(type)
        @type = type
        yield
        verify_required
      end

      def self.required
        {
          'type' => String
        }
      end

      def to_h
        result = {}
        instance_values.each do |key, value|
          result[key.camelize(:lower)] = value unless value.nil?
        end
        result
      end

      private

      def verify_required
        self.class.required.each { |key, value| verify_instance_value_type key, value }
      end

      def verify_instance_value_type(name, type)
        raise TypeError, "@#{name}: #{instance_values[name]}, expect to be #{type}" unless instance_values[name].is_a? type
      end
    end
  end
end
