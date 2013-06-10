class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer     :lesson_id,   null: false
      t.foreign_key :lessons
      t.references  :completable, null: false, polymorphic: true
      t.integer     :position,    null: false

      t.timestamps
    end
    add_index :activities, [:position, :lesson_id], unique: true
  end
end
