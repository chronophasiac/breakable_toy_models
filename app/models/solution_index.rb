# == Schema Information
#
# Table name: solution_indices
#
#  id          :integer          not null, primary key
#  start_index :integer          not null
#  end_index   :integer          not null
#  card_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SolutionIndex < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :solution_indices

  validates_presence_of :start_index, :end_index, :card

  validates :end_index, numericality: { only_integer: true, greater_than_or_equal_to: :start_index }

  attr_accessible :card_id, :end_index, :start_index
end
