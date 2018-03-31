module Line
  module Format
    class Template::Buttons < Template
      attr_accessor :thumbnail_image_url, :image_aspect_ratio,
                    :image_size, :image_background_color, :title,
                    :text, :default_action, :actions

      def initialize(thumbnail_image_url: nil, image_aspect_ratio: nil,
                    image_size: nil, image_background_color: nil, title: nil,
                    text: nil, default_action: nil, actions: [])
        super 'buttons' do
          @thumbnail_image_url = thumbnail_image_url
          @image_aspect_ratio = image_aspect_ratio
          @image_size = image_size
          @image_background_color = image_background_color
          @title = title
          @text = text
          @default_action = default_action
          @actions = actions
          yield self if block_given?
        end
      end

      def self.required
        {
          'type' => String,
          'text' => String,
          'actions' => Array
        }
      end

      def to_h
        result = super
        result['actions'] = result['actions'].map { |action| action.to_h }
        result
      end
    end
  end
end
