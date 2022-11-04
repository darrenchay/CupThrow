class CreateGameData < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :type
      t.string :colour
      t.integer :sides
      t.float :denomination
      t.integer :result
      t.belongs_to :container, index: true
      t.timestamps      
    end

    create_table :containers do |t|
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps      
    end

    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :bag_id, null: false
      t.integer :player_cup_id, null: false
      t.integer :server_cup_id, null: false
      t.timestamps
    end
    add_foreign_key :games, :containers, column: :bag_id
    add_foreign_key :games, :containers, column: :player_cup_id
    add_foreign_key :games, :containers, column: :server_cup_id
  end
end
