class Room < ApplicationRecord
  has_many :danmus, dependent: :destroy
  belongs_to :creater, class_name: 'User', foreign_key: 'creater_id', optional: true

  before_create do
    before_create_setting
  end

  scope :online, -> { where(online: true) }

  def new_auth_token
    token = generate_unique_secure_token
    loop do
      break token unless self.class.exists?(auth_token: token)

      token = generate_unique_secure_token
    end
    self.auth_token = token
    self.auth_token_sent_at = Time.now
  end

  def new_key
    kee = generate_key
    loop do
      break key unless self.class.online.exists?(key: kee)

      kee = generate_key
    end
    self.key = kee
  end

  def auth?(token)
    auth_token == token
  end

  def pop_danmus
    result = $redis.lrange("room_#{id}", 0, -1)
    $redis.del("room_#{id}")
    "\[#{result.join(',')}\]"
  end

  private

  def before_create_setting
    self.online = true
    new_key
    new_auth_token
  end

  def generate_key
    # SecureRandom.hex(3) # 6位英數混合
    SecureRandom.random_number.to_s[2..5] # 4位數字
  end

  def generate_unique_secure_token
    SecureRandom.base58(24)
  end
end
