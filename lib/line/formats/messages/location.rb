module Line
  module Format
    class Message::Location < Message
      attr_accessor :title, :address, :latitude, :longitude

      def initialize(title: nil, address: nil, latitude: nil, longitude: nil)
        super 'location' do
          @title = title
          @address = address
          @latitude = latitude
          @longitude = longitude
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'title' => String,
          'address' => String,
          'latitude' => Float,
          'longitude' => Float
        }
      end
    end
  end
end
