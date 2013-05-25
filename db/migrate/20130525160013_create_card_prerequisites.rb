class CreateCardPrerequisites < ActiveRecord::Migration
  def change
    create_table :card_prerequisites do |t|
      t.integer :card_id
      t.foreign_key :cards
      t.integer :assignment_id
      t.foreign_key :assignments

      t.timestamps
    end
  end
end
