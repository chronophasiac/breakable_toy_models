class CreateSolutionPositions < ActiveRecord::Migration
  def change
    create_table :solution_positions do |t|
      t.integer     :start_position,  null: false
      t.integer     :end_position,    null: false
      t.integer     :card_id,         null: false
      t.foreign_key :cards

      t.timestamps
    end
    add_index :solution_positions, :card_id
  end
end
