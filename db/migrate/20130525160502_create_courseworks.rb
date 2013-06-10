class CreateCourseworks < ActiveRecord::Migration
  def change
    create_table :courseworks do |t|
      t.integer     :user_id,       null: false
      t.foreign_key :users
      t.integer     :assignment_id, null: false
      t.foreign_key :assignments
      t.boolean     :completed,     null: false, default: false

      t.timestamps
    end
    add_index :courseworks, :user_id
    add_index :courseworks, :assignment_id
  end
end
