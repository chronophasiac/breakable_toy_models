# == Schema Information
#
# Table name: solution_positions
#
#  id             :integer          not null, primary key
#  start_position :integer          not null
#  end_position   :integer          not null
#  card_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class SolutionPosition < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :solution_positions

  validates_presence_of :start_position, :end_position, :card

  validates :start_position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :end_position, numericality: { only_integer: true, greater_than_or_equal_to: :start_position }

  attr_accessible :card_id, :end_position, :start_position
end
