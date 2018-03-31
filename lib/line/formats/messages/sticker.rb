module Line
  module Format
    class Message::Sticker < Message
      attr_accessor :package_id, :sticker_id

      def initialize(package_id: nil, sticker_id: nil)
        super 'sticker' do
          @package_id = package_id
          @sticker_id = sticker_id
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'package_id' => String,
          'sticker_id' => String
        }
      end
    end
  end
end
