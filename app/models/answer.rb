class Answer < ActiveRecord::Base
  attr_accessible :card_id, :end_position, :start_position

  validates_presence_of :card_id
  validates_presence_of :start_position
  validates_presence_of :end_position
  validates_presence_of :card

  belongs_to  :card,
              inverse_of: :answers
end
