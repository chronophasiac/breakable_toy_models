class CreateSyllabuses < ActiveRecord::Migration
  def change
    create_table :syllabuses do |t|
      t.integer :lesson_id, null: false
      t.foreign_key :lessons
      t.integer :assignment_id, null: false
      t.foreign_key :assignments
      t.integer :position, null: false

      t.timestamps
    end
  end
end
