class CreateSolutionStrings < ActiveRecord::Migration
  def change
    create_table :solution_strings do |t|
      t.string      :regex,     null: false
      t.boolean     :canonical, null: false, default: false
      t.integer     :card_id,   null: false
      t.foreign_key :cards

      t.timestamps
    end
    add_index :solution_strings, :card_id
  end
end
