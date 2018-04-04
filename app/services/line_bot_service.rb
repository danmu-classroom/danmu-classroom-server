class LineBotService
  include Line::Format
  attr_reader :bot, :chats, :request

  def initialize(request)
    @request = request
    @body = @request.raw_post
    @signature = @request.env['HTTP_X_LINE_SIGNATURE']
    @bot = Line::Bot::Client.new(Rails.application.config.line_bot)
    @chats = @bot.parse_events_from(@body)
    raise 'signature invalid' unless @bot.validate_signature(@body, @signature)
  end

  def perform
    @chats.each do |chat|
      token = chat['replyToken']
      message = bulid_msg_and_react(chat)
      next if message.blank?

      @bot.reply_message token, message
    end
  end

  private

  def bulid_msg_and_react(chat)
    # write your reply logic here
    uid = chat['source'].dig('userId')
    sender = Sender.find_or_create_by(uid: uid, provider: 'line')
    case chat
    when Line::Bot::Event::Message
      text = chat['message'].fetch('text') { '' }
      return setting_room_key(sender, text) if sender.last_action == 'ask_for_setting_room_key'
      return no_room_key unless sender.room_key.present?
      return creating_danmu(text)
    when Line::Bot::Event::Postback
      data = chat['postback'].fetch('data') { '' }
      data = ActionController::Parameters.new(Rack::Utils.parse_nested_query(data))
      return ask_for_setting_room_key(sender) if data[:action] == 'ask_for_setting_room_key'
    end
  end

  # messages and reactions
  def setting_room_key(sender, key)
    p 'setting_room_key'
    # react
    sender.room_key = key
    # return message
    Message::Text(text: "Room key : #{key}").to_h
  end

  def no_room_key
    p 'no_room_key'
    # react
    # nothing
    # return message
    Message::Template.new do |t|
      t.alt_text = 'Set the room key first'
      t.template = Template::Buttons.new do |b|
        b.text = 'Set the room key first'
        b.actions << Action::Postback.new do |a|
          a.label = 'setting room key now'
          a.data = 'action=ask_for_setting_room_key'
        end
      end
    end
  end

  def creating_danmu(sender, content)
    p 'creating_danmu'
    # react
    sender.danmu(content)
    # return message
    Message::Text(text: "received message, danmu to room##{sender.room_key}").to_h
  end

  def ask_for_setting_room_key(sender)
    p 'ask_for_setting_room_key'
    # react
    sender.ask_for_setting_room_key
    # return message
    Message::Text(text: 'Please enter your room key :').to_h
  end
end
