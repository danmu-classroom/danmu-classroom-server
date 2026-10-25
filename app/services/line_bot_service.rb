# frozen_string_literal: true

class LineBotService
  Messaging = Line::Bot::V2::MessagingApi

  attr_reader :bot, :chats, :request

  def initialize(request)
    @request = request
    @body = @request.raw_post
    @signature = @request.env["HTTP_X_LINE_SIGNATURE"].to_s
    @bot = Singletons.instance.line_bot
    @chats = Singletons.instance.line_webhook_parser.parse(body: @body, signature: @signature)
  rescue Line::Bot::V2::WebhookParser::InvalidSignatureError
    raise "signature invalid"
  end

  def perform
    @chats.each do |chat|
      message = bulid_msg_and_react(chat)
      next if message.blank?

      @bot.reply_message(reply_message_request: Messaging::ReplyMessageRequest.new(reply_token: chat.reply_token, messages: [ message ]))
    end
  end

  private

  def bulid_msg_and_react(chat)
    # write your reply logic here
    uid = chat.source.try(:user_id)
    sender = Sender.find_or_create_by(uid: uid, provider: "line")
    case chat
    when Line::Bot::V2::Webhook::MessageEvent
      text = chat.message.try(:text) || ""
      return setting_room_key(sender, text) if sender.last_action == "ask_for_setting_room_key"
      return no_room_key unless sender.room_key.present?

      creating_danmu(sender, text)
    when Line::Bot::V2::Webhook::PostbackEvent
      data = chat.postback.data.to_s
      data = ActionController::Parameters.new(Rack::Utils.parse_nested_query(data))
      return ask_for_setting_room_key(sender) if data[:action] == "ask_for_setting_room_key"

      clean_room_key(sender) if data[:action] == "ask_for_delete_room_key"
    end
  end

  def postback(label, data)
    Messaging::PostbackAction.new(label: label, data: data)
  end

  # messages and reactions
  def setting_room_key(sender, key)
    # react
    sender.room_key = key.strip.downcase
    # return message
    Messaging::TextMessage.new(text: "你輸入的房號為 #{key}")
  end

  def no_room_key
    # react
    # nothing
    # return message
    Messaging::TemplateMessage.new(
      alt_text: "Set the room key first",
      template: Messaging::ButtonsTemplate.new(
        text: "請先告訴我你要去哪間房間嗨",
        actions: [ postback("輸入房號", "action=ask_for_setting_room_key") ]
      )
    )
  end

  def creating_danmu(sender, content)
    # react
    text = if sender.send_danmu(content)
             "成功發送彈幕至 ##{sender.room_key}"
    else
             "出錯啦，無法發送彈幕至 ##{sender.room_key}，要不是你房號打錯，就是我程式寫錯（希望是你打錯）"
    end
    # return message
    Messaging::TemplateMessage.new(
      alt_text: text,
      template: Messaging::ButtonsTemplate.new(
        text: text,
        actions: [
          postback("換個房間", "action=ask_for_setting_room_key"),
          postback("離開房間", "action=ask_for_delete_room_key")
        ]
      )
    )
  end

  def ask_for_setting_room_key(sender)
    # react
    sender.last_action = "ask_for_setting_room_key"
    # return message
    Messaging::TextMessage.new(text: "輸入房間號碼，不知道房號多少的請看螢幕或是問隔壁（要不然就猜猜看？）")
  end

  def clean_room_key(sender)
    # react
    old_key = sender.room_key
    sender.delete_room_key
    # return message
    Messaging::TextMessage.new(text: "已經離開房間##{old_key}，人客欸下次再來喔~")
  end
end
