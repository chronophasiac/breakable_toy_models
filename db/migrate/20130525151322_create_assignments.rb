class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string  :title,           null: false
      t.text    :instructions,    null: false
      t.string  :url
      t.string  :assignment_type, null: false
      t.text    :summary,         null: false

      t.timestamps
    end
  end
end
