require 'test_helper'

class ApiDanmusTest < ActionDispatch::IntegrationTest
  def post_danmu(key, content, uid: 'u1')
    post "/api/rooms/#{key}/danmus",
         params: { danmu: { content: content, sender: { provider: 'test', uid: uid } } },
         as: :json
  end

  test 'danmus posted to a room are popped once by the screen' do
    room = create_room

    post_danmu(room['key'], 'hello')
    assert_response :created
    assert_equal 'hello', json['content']
    post_danmu(room['key'], '彈幕', uid: 'u2')
    assert_response :created

    get "/api/rooms/#{room['key']}/danmus", params: { auth_token: room['auth_token'] }
    assert_response :ok
    assert_equal %w[彈幕 hello], json.map { |d| d['content'] }
    assert(json.all? { |d| d['created_at'].present? })

    get "/api/rooms/#{room['key']}/danmus", params: { auth_token: room['auth_token'] }
    assert_equal [], json
  end

  test 'the same sender is reused across danmus' do
    room = create_room

    assert_difference -> { Sender.count }, 1 do
      post_danmu(room['key'], 'one')
      post_danmu(room['key'], 'two')
    end
    assert_equal 2, Danmu.count
  end

  test 'polling danmus needs the room auth token' do
    room = create_room

    get "/api/rooms/#{room['key']}/danmus", params: { auth_token: 'wrong' }

    assert_response :unauthorized
    assert_equal({ 'error' => 'wrong auth_token' }, json)
  end

  test 'offline rooms reject new danmus' do
    room = create_room
    Room.find(room['id']).update!(online: false)

    post_danmu(room['key'], 'late')

    assert_response :unprocessable_entity
    assert_equal ['Room is offline, can not add new danmu.'], json['base']
  end

  test 'empty danmus are rejected' do
    room = create_room

    post_danmu(room['key'], '')

    assert_response :unprocessable_entity
    assert json['content'].present?
  end
end
