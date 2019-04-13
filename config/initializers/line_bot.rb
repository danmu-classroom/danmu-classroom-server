require 'line/bot'
require 'line/bot/message_builder'

# set channel secret and token
Rails.application.config.line_bot = {
  channel_secret: Rails.application.credentials.line_channel_secret!,
  channel_token: Rails.application.credentials.line_channel_token!
}
