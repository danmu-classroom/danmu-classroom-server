class LineBotService
  include Line::Bot::MessageBuilder
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
      message = bulid_msg_and_react(chat).to_h
      logger.info message
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
      return creating_danmu(sender, text)
    when Line::Bot::Event::Postback
      data = chat['postback'].fetch('data') { '' }
      data = ActionController::Parameters.new(Rack::Utils.parse_nested_query(data))
      return ask_for_setting_room_key(sender) if data[:action] == 'ask_for_setting_room_key'
      return clean_room_key(sender) if data[:action] == 'ask_for_delete_room_key'
    end
  end

  # messages and reactions
  def setting_room_key(sender, key)
    # react
    sender.room_key = key
    # return message
    Message::Text.new(text: "Room key : #{key}")
  end

  def no_room_key
    # react
    # nothing
    # return message
    Message::Template.new do |t|
      t.alt_text = 'Set the room key first'
      t.template = Template::Buttons.new do |b|
        b.text = 'Set the room key first'
        b.actions << Action::Postback.new do |a|
          a.label = 'Setting room key'
          a.data = 'action=ask_for_setting_room_key'
        end
      end
    end
  end

  def creating_danmu(sender, content)
    # react
    sender.send_danmu(content)
    # return message
    text = "Room##{sender.room_key} danmu received."
    Message::Template.new do |t|
      t.alt_text = text
      t.template = Template::Buttons.new do |b|
        b.text = text
        b.actions << Action::Postback.new do |a|
          a.label = 'Change room key'
          a.data = 'action=ask_for_setting_room_key'
        end
        b.actions << Action::Postback.new do |a|
          a.label = 'Exit room'
          a.data = 'action=ask_for_delete_room_key'
        end
      end
    end
  end

  def ask_for_setting_room_key(sender)
    # react
    sender.last_action = 'ask_for_setting_room_key'
    # return message
    Message::Text.new(text: 'Please enter your room key :')
  end

  def clean_room_key(sender)
    # react
    old_key = sender.room_key
    sender.delete_room_key
    # return message
    Message::Text.new(text: "Exit Room##{old_key} successed")
  end
end
