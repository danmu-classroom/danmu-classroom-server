class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :key
      t.boolean :online
      t.string :redis
      t.string :channel
      t.string :stream_ip
      t.string :creater_ip
      t.timestamps
    end
    add_index :rooms, :key
    add_index :rooms, :stream_ip
    add_index :rooms, :creater_ip
    add_index :rooms, :channel
    add_index :rooms, :online
  end
end
