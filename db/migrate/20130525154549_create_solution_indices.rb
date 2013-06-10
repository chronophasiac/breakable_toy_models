class CreateSolutionIndices < ActiveRecord::Migration
  def change
    create_table :solution_indices do |t|
      t.integer     :start_index, null: false
      t.integer     :end_index, null: false
      t.integer     :card_id, null: false
      t.foreign_key :cards

      t.timestamps
    end
    add_index :solution_indices, :card_id
  end
end
