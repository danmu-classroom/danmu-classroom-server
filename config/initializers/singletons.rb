# frozen_string_literal: true

class Singletons
  include Singleton
  attr_reader :redis, :line_bot, :line_webhook_parser

  def initialize
    config = Rails.application.config
    @redis = Redis.new(url: config.redis_url)
    @line_bot = Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: config.line_bot[:channel_token].to_s)
    @line_webhook_parser = Line::Bot::V2::WebhookParser.new(channel_secret: config.line_bot[:channel_secret].to_s)
  end
end
