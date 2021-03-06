class SolutionPosition < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :solution_positions

  validates_presence_of :start_position, :end_position, :card

  validates :start_position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :end_position, numericality: { only_integer: true, greater_than_or_equal_to: :start_position }

  attr_accessible :card_id, :end_position, :start_position

  def response_match?(response)
    range = start_position..end_position
    range.include?(response[:position].to_i)
  end
end
