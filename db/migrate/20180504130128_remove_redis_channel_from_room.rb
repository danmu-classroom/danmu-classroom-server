class RemoveRedisChannelFromRoom < ActiveRecord::Migration[5.1]
  def change
    remove_index :rooms, :channel
    remove_columns :rooms, :redis, :channel
    add_column :rooms, :webhook, :string
    add_column :rooms, :auth_token, :string
    add_column :rooms, :auth_token_sent_at, :datetime
    add_index :rooms, :auth_token, unique: true
  end
end
