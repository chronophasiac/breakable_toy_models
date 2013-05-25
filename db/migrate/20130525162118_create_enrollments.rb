class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.foreign_key :users
      t.integer :lesson_id
      t.foreign_key :lessons
      t.datetime :last_accessed_at, null: false

      t.timestamps
    end
  end
end
