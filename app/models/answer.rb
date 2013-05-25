class Answer < ActiveRecord::Base
  attr_accessible :card_id, :end_position, :start_position

  validates_presence_of :start_position
  validates_presence_of :end_position

  belongs_to :card
end
