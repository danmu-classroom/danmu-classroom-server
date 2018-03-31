module Line
  module Format
    class Action::Uri < Action
      attr_accessor :label, :uri

      def initialize(label: nil, uri: nil)
        super 'uri' do
          @label = label
          @uri = uri
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'label' => String,
          'uri' => String
        }
      end
    end
  end
end
