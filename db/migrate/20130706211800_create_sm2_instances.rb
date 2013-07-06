class CreateSm2Instances < ActiveRecord::Migration
  def change
    create_table :sm2_instances do |t|
      t.float       :easiness_factor
      t.integer     :number_repetitions
      t.integer     :quality_of_last_recall
      t.date        :next_repetition
      t.integer     :repetition_interval
      t.date        :last_studied
      t.integer     :card_submission_id,       null: false
      t.foreign_key :card_submissions

      t.timestamps
    end
    add_index :sm2_instances, :card_submission_id
  end
end
