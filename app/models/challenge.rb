class Challenge < ActiveRecord::Base
  attr_accessible :lesson_id, :position, :title

  validates_presence_of :title
  validates_presence_of :position
  validates_presence_of :lesson
  
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  has_many  :challenge_progressions,
            inverse_of: :challenge

  has_many  :users,
            through: :challenge_progressions,
            inverse_of: :challenges

  belongs_to  :lesson,
              inverse_of: :challenges

  has_many  :challenge_decks,
            inverse_of: :challenge

  has_many  :cards,
            through: :challenge_decks,
            inverse_of: :challenges
end
