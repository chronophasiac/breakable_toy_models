class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string  :title,         null: false
      t.text    :instructions,  null: false
      t.text    :problem,       null: false
      t.string  :solution_type, null:false

      t.timestamps
    end
  end
end
