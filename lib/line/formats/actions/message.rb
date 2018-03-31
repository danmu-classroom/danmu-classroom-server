module Line
  module Format
    class Action::Message < Action
      attr_accessor :label, :text

      def initialize(label: nil, text: nil)
        super 'message' do
          @label = label
          @text = text
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'label' => String,
          'text' => String
        }
      end
    end
  end
end
