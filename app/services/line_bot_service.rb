class LineBotService
  include Line::Format
  attr_reader :bot, :chats, :request

  def initialize(request)
    @request = request
    @body = @request.raw_post
    @signature = @request.env['HTTP_X_LINE_SIGNATURE']
    @bot = Line::Bot::Client.new(Rails.application.config.line_bot)
    @chats = @bot.parse_events_from(@body)
  end

  def perform
    verify_signature
    @chats.each do |chat|
      token = chat['replyToken']
      message = bulid_reply_message(chat)
      next if message.blank?

      @bot.reply_message token, message
    end
  end

  private

  def verify_signature
    raise 'signature invalid' unless @bot.validate_signature(@body, @signature)
  end

  def bulid_reply_message(chat)
    # write your reply logic here
    case chat
    when Line::Bot::Event::Message
      text = chat.message.fetch('text') { '' }
    when Line::Bot::Event::Postback
      data = chat.as_json.dig('src', 'postback', 'data') || ''
      data = ActionController::Parameters.new(Rack::Utils.parse_nested_query(data))
    end
  end
end
