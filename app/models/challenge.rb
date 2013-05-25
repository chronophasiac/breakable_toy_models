class Challenge < ActiveRecord::Base
  attr_accessible :lesson_id, :position, :title

  belongs_to  :lesson,
              inverse_of: :challenge
end
