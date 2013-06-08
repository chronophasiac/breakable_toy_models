class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title, null: false
      t.integer :position, null: false
      t.integer :lesson_id, null: false
      t.foreign_key :lessons

      t.timestamps
    end
  end
end
