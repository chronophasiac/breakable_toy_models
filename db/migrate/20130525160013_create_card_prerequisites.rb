class CreateCardPrerequisites < ActiveRecord::Migration
  def change
    create_table :card_prerequisites do |t|
      t.integer     :card_id,       null: false
      t.foreign_key :cards
      t.integer     :assignment_id, null: false
      t.foreign_key :assignments

      t.timestamps
    end
    add_index :card_prerequisites, :card_id
    add_index :card_prerequisites, :assignment_id
  end
end
