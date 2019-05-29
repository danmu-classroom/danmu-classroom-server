class DeleteRoomsStreamIp < ActiveRecord::Migration[5.2]
  def change
    remove_index :rooms, :stream_ip
    remove_columns :rooms, :stream_ip, :webhook
    change_column_default :rooms, :online, false
  end
end
