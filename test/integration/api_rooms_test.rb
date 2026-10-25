require "test_helper"

class ApiRoomsTest < ActionDispatch::IntegrationTest
  test "POST /api/rooms creates an online room with a 4-digit key and auth token" do
    room = create_room

    assert_match(/\A\d{4}\z/, room["key"])
    assert_equal true, room["online"]
    assert_equal 24, room["auth_token"].length
    assert room["auth_token_sent_at"].present?
    assert_equal "http://www.example.com/api/rooms/#{room['key']}", room["url"]
    # Existing quirk: Location uses the room id although the route param is the key
    assert_equal "/api/rooms/#{room['id']}", response.headers["Location"]
  end

  test "GET /api/rooms lists online rooms without auth tokens" do
    first = create_room
    second = create_room
    Room.create!.update!(online: false)

    get "/api/rooms"

    assert_response :ok
    assert_equal [ second["key"], first["key"] ], json["rooms"].map { |r| r["key"] }
    assert_equal 2, json["room_counts"]
    assert_equal "http://www.example.com/api/rooms", json["url"]
    assert(json["rooms"].none? { |r| r.key?("auth_token") })
  end

  test "GET /api/rooms/:key shows the room without its auth token" do
    room = create_room

    get "/api/rooms/#{room['key']}"

    assert_response :ok
    assert_equal %w[id key online url], json.keys
    assert_equal room["key"], json["key"]
  end

  test "GET /api/rooms/:key returns 404 for an unknown key" do
    get "/api/rooms/0000"

    assert_response :not_found
  end

  test "PATCH /api/rooms/:key assigns the room to a user with valid credentials" do
    user = User.create!(email: "host@example.com", password: "secret123")
    room = create_room

    patch "/api/rooms/#{room['key']}",
          params: { auth_token: room["auth_token"], email: "host@example.com", password: "secret123" }

    assert_response :ok
    assert_equal user, Room.find(room["id"]).creater
  end

  test "PATCH /api/rooms/:key rejects a wrong password or auth token" do
    User.create!(email: "host@example.com", password: "secret123")
    room = create_room

    patch "/api/rooms/#{room['key']}",
          params: { auth_token: room["auth_token"], email: "host@example.com", password: "wrong" }
    assert_response :unauthorized
    assert_equal({ "error" => "wrong email or password" }, json)

    patch "/api/rooms/#{room['key']}",
          params: { auth_token: "bad", email: "host@example.com", password: "secret123" }
    assert_response :unauthorized
    assert_equal({ "error" => "wrong auth_token" }, json)
  end
end
