require "test_helper"

class LineCallbackTest < ActionDispatch::IntegrationTest
  setup do
    @replies = []
    replies = @replies
    @bot = Singletons.instance.line_bot
    # Capture replies as the JSON payload the SDK would send to LINE
    @bot.define_singleton_method(:reply_message) do |reply_message_request:|
      utils = Line::Bot::V2::Utils
      payload = utils.deep_compact(utils.deep_camelize(utils.deep_to_hash(reply_message_request)))
      payload[:messages].each { |message| replies << [ payload[:replyToken], message ] }
    end
  end

  teardown do
    @bot.singleton_class.send(:remove_method, :reply_message)
  end

  def line_event(event)
    body = { destination: "bot", events: [ event ] }.to_json
    secret = Rails.application.config.line_bot[:channel_secret]
    signature = Base64.strict_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new("SHA256"), secret, body))
    post "/api/line/callback", params: body,
                               headers: { "Content-Type" => "application/json", "X-Line-Signature" => signature }
  end

  def delivery
    { webhookEventId: SecureRandom.uuid, deliveryContext: { isRedelivery: false } }
  end

  def text_event(text, user: "line-user-1")
    { type: "message", replyToken: "token-#{text}", timestamp: 0, mode: "active", **delivery,
      source: { type: "user", userId: user },
      message: { id: "1", type: "text", text: text, quoteToken: "quote-token" } }
  end

  def postback_event(data, user: "line-user-1")
    { type: "postback", replyToken: "token-#{data}", timestamp: 0, mode: "active", **delivery,
      source: { type: "user", userId: user },
      postback: { data: data } }
  end

  test "a LINE user sets a room key and sends a danmu to the screen" do
    room = create_room

    line_event(text_event("hi"))
    assert_response :ok
    assert_equal "Success", response.body
    assert_equal "template", @replies.last[1][:type]
    assert_equal "action=ask_for_setting_room_key", @replies.last[1][:template][:actions].first[:data]

    line_event(postback_event("action=ask_for_setting_room_key"))
    assert_equal({ type: "text", text: "輸入房間號碼，不知道房號多少的請看螢幕或是問隔壁（要不然就猜猜看？）" }, @replies.last[1])

    line_event(text_event(room["key"]))
    assert_equal({ type: "text", text: "你輸入的房號為 #{room['key']}" }, @replies.last[1])

    line_event(text_event("上課好無聊"))
    assert_equal "成功發送彈幕至 ##{room['key']}", @replies.last[1][:altText]

    get "/api/rooms/#{room['key']}/danmus", params: { auth_token: room["auth_token"] }
    assert_equal [ "上課好無聊" ], json.map { |d| d["content"] }
    assert_equal "line", Sender.last.provider
    assert_equal "line-user-1", Sender.last.uid
  end

  test "sending to a wrong room key reports an error" do
    line_event(postback_event("action=ask_for_setting_room_key"))
    line_event(text_event("9999"))
    line_event(text_event("hello"))

    assert_match(/\A出錯啦，無法發送彈幕至 #9999/, @replies.last[1][:altText])
  end

  test "leaving a room clears the room key" do
    line_event(postback_event("action=ask_for_setting_room_key"))
    line_event(text_event("1234"))
    line_event(postback_event("action=ask_for_delete_room_key"))

    assert_equal({ type: "text", text: "已經離開房間#1234，人客欸下次再來喔~" }, @replies.last[1])
    assert_nil Sender.last.room_key
  end

  test "requests with a bad signature are rejected" do
    assert_raises(RuntimeError, "signature invalid") do
      post "/api/line/callback", params: { events: [] }.to_json,
                                 headers: { "Content-Type" => "application/json", "X-Line-Signature" => "bad" }
    end
  end
end
