module Line
  module Format
    class Message::Audio < Message
      attr_accessor :original_content_url, :duration

      def initialize(original_content_url: nil, duration: nil)
        super 'audio' do
          @original_content_url = original_content_url
          @duration = duration
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'original_content_url' => String,
          'duration' => Integer
        }
      end
    end
  end
end
