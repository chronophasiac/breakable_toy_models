class CreateChallengeProgressions < ActiveRecord::Migration
  def change
    create_table :challenge_progressions do |t|
      t.integer :user_id
      t.foreign_key :users
      t.integer :challenge_id
      t.foreign_key :challenges
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
