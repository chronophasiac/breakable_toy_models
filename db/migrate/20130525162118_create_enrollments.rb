class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer     :user_id,           null: false
      t.foreign_key :users
      t.integer     :lesson_id,         null: false
      t.foreign_key :lessons
      t.datetime    :last_accessed_at,  null: false

      t.timestamps
    end
    add_index :enrollments, :user_id
    add_index :enrollments, [:lesson_id, :user_id], unique: true
  end
end
