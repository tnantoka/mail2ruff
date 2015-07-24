class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :uid, null: false
      t.integer :note_id, null: false
      t.integer :page_id
      t.string :team, null: false
      t.string :note, null: false
      t.integer :user_id, null: false
      t.string :token, null: false

      t.timestamps null: false
    end

    add_index :addresses, [:uid], unique: true
    add_index :addresses, [:note_id, :user_id], unique: true
  end
end
