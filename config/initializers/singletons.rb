# frozen_string_literal: true

class Singletons
  include Singleton
  attr_reader :redis, :line_bot, :pusher

  def initialize
    @redis = Redis.new(url: Rails.application.config.redis_url)
    @line_bot = Line::Bot::Client.new(Rails.application.config.line_bot)
    @pusher = Pusher::Client.new(Rails.application.config.pusher)
  end
end
