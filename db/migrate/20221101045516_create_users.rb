class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :points, :default => 0
      t.text :items, array: true

      t.timestamps
    end
  end
end
