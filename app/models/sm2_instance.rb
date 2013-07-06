class Sm2Instance < ActiveRecord::Base
  include SuperMemo::SM2

  belongs_to      :card_submission,
                  inverse_of: :sm2_instance
  attr_accessible :easiness_factor, :last_studied, :next_repetition, :card_submission_id,
                  :number_repetitions, :quality_of_last_recall, :repetition_interval
  after_create    :reset_spaced_repetition_data

  def process(recall_result)
    process_recall_result(recall_result)
    save
  end
end
