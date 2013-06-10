class CreateCardSubmissions < ActiveRecord::Migration
  def change
    create_table :card_submissions do |t|
      t.integer     :user_id, null: false
      t.foreign_key :users
      t.integer     :card_id, null: false
      t.foreign_key :cards
      t.boolean     :helpful

      t.timestamps
    end
    add_index :card_submissions, :user_id
    add_index :card_submissions, :card_id
  end
end
