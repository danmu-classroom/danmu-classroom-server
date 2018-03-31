module Line
  module Format
    class Action::Postback < Action
      attr_accessor :label, :data, :display_text

      def initialize(label: nil, data: nil, display_text: nil)
        super 'postback' do
          @label = label
          @data = data
          @display_text = display_text
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'label' => String,
          'data' => String
        }
      end
    end
  end
end
