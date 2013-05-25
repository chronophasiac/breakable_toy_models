class CreateCardSubmissions < ActiveRecord::Migration
  def change
    create_table :card_submissions do |t|
      t.integer :user_id
      t.foreign_key :users
      t.integer :card_id
      t.foreign_key :cards
      t.boolean :helpful

      t.timestamps
    end
  end
end
