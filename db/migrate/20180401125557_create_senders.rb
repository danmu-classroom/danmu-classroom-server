class CreateSenders < ActiveRecord::Migration[5.1]
  def change
    create_table :senders do |t|
      t.string :uid
      t.string :provider
      
      t.timestamps
    end
    add_index :senders, %i[uid provider], unique: true
  end
end
