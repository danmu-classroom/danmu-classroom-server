# frozen_string_literal: true

module RedisAccessible
  extend ActiveSupport::Concern

  private

  def redis
    Singletons.instance.redis
  end
end
