class AddRoomRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference(:rooms, :creater, foreign_key: {to_table: :users})
  end
end
