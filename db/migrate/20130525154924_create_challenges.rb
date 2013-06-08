class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
