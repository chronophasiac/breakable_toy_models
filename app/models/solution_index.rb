class SolutionIndex < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :solution_indices

  validates_presence_of :start_index, :end_index, :card

  validates :end_index, numericality: { only_integer: true, greater_than_or_equal_to: :start_index }

  attr_accessible :card_id, :end_index, :start_index
end
