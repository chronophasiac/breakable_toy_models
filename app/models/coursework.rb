class Coursework < ActiveRecord::Base
  attr_accessible :assignment_id, :completed, :user_id

  validates_presence_of :completed

  belongs_to  :user,
              inverse_of: :coursework


  belongs_to  :assignment,
              inverse_of: :coursework
end
