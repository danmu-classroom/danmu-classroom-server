module Line
  module Format
    class Message::Template < Message
      attr_accessor :alt_text, :template

      def initialize(alt_text: nil, template: nil)
        super 'template' do
          @alt_text = alt_text
          @template = template
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'alt_text' => String,
          'template' => Template
        }
      end

      def to_h
        result = super
        result['template'] = template.to_h
        result
      end
    end
  end
end
