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
    sender.room_key = key.strip.downcase
    # return message
    Message::Text.new(text: "你輸入的房號為 #{key}")
  end

  def no_room_key
    # react
    # nothing
    # return message
    Message::Template.new do |t|
      t.alt_text = 'Set the room key first'
      t.template = Template::Buttons.new do |b|
        b.text = '請先告訴我你要去哪間房間嗨'
        b.actions << Action::Postback.new do |a|
          a.label = '輸入房號'
          a.data = 'action=ask_for_setting_room_key'
        end
      end
    end
  end

  def creating_danmu(sender, content)
    # react
    text = if sender.send_danmu(content)
             "成功發送彈幕至 ##{sender.room_key}"
           else
             "出錯啦，無法發送彈幕至 ##{sender.room_key}，要不是你房號打錯，就是我程式寫錯（希望是你打錯）"
           end
    # return message
    Message::Template.new do |t|
      t.alt_text = text
      t.template = Template::Buttons.new do |b|
        b.text = text
        b.actions << Action::Postback.new do |a|
          a.label = '換個房間'
          a.data = 'action=ask_for_setting_room_key'
        end
        b.actions << Action::Postback.new do |a|
          a.label = '離開房間'
          a.data = 'action=ask_for_delete_room_key'
        end
      end
    end
  end

  def ask_for_setting_room_key(sender)
    # react
    sender.last_action = 'ask_for_setting_room_key'
    # return message
    Message::Text.new(text: '輸入房間號碼，不知道房號多少的請看螢幕或是問隔壁（要不然就猜猜看？）')
  end

  def clean_room_key(sender)
    # react
    old_key = sender.room_key
    sender.delete_room_key
    # return message
    Message::Text.new(text: "已經離開房間##{old_key}，人客欸下次再來喔~")
  end
end
