# == Schema Information
#
# Table name: answers
#
#  id             :integer          not null, primary key
#  start_position :integer          not null
#  end_position   :integer          not null
#  card_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Answer < ActiveRecord::Base
  attr_accessible :card_id, :end_position, :start_position

  validates_presence_of :start_position
  validates_presence_of :end_position
  validates_presence_of :card

  validates :end_position, numericality: { only_integer: true, greater_than_or_equal_to: :start_position }

  belongs_to  :card,
              inverse_of: :answers
end
