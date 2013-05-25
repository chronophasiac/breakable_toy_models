class CreateLessonAssignments < ActiveRecord::Migration
  def change
    create_table :lesson_assignments do |t|
      t.integer :lesson_id
      t.foreign_key :lessons
      t.integer :assignment_id
      t.foreign_key :assignments
      t.integer :position, null: false

      t.timestamps
    end
  end
end
