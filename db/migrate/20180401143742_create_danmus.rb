class CreateDanmus < ActiveRecord::Migration[5.1]
  def change
    create_table :danmus do |t|
      t.string :content
      t.references :room, foreign_key: true
      t.references :sender, foreign_key: true

      t.timestamps
    end
  end
end
