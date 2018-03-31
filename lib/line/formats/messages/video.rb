module Line
  module Format
    class Message::Video < Message
      attr_accessor :original_content_url, :preview_image_url

      def initialize(original_content_url: nil, preview_image_url: nil)
        super 'video' do
          @original_content_url = original_content_url
          @preview_image_url = preview_image_url
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'original_content_url' => String,
          'preview_image_url' => String
        }
      end
    end
  end
end
