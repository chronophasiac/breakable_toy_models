class CreateAssignmentRatings < ActiveRecord::Migration
  def change
    create_table :assignment_ratings do |t|
      t.integer :user_id
      t.foreign_key :users
      t.integer :assignment_id
      t.foreign_key :assignments
      t.boolean :helpful, null: false, default: false

      t.timestamps
    end
  end
end
