require 'test_helper'

class WebPagesTest < ActionDispatch::IntegrationTest
  test 'landing page renders with compiled assets' do
    get '/'

    assert_response :ok
    assert_select 'title', '彈幕教室'
    assert_select 'h2', '參與者'
    assert_select 'link[rel=stylesheet]'
    assert_select 'script[src]'
  end

  test 'room history requires sign in' do
    get '/rooms'

    assert_redirected_to '/users/sign_in'
  end

  test 'sign in and sign up pages render' do
    get '/users/sign_in'
    assert_response :ok
    get '/users/sign_up'
    assert_response :ok
  end

  test 'a signed-in host sees their rooms and danmu history' do
    user = User.create!(email: 'host@example.com', password: 'secret123')
    room = Room.create!(creater: user)
    sender = Sender.create!(provider: 'test', uid: 'u1')
    room.danmus.create!(sender: sender, content: '歷史彈幕')
    sign_in user

    get '/rooms'
    assert_response :ok
    assert_select 'td', room.key

    get "/rooms/#{room.id}/danmus"
    assert_response :ok
    assert_select 'td', '歷史彈幕'
  end
end
