class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :start_position, null: false
      t.integer :end_position, null: false
      t.integer :card_id
      t.foreign_key :cards

      t.timestamps
    end
  end
end
