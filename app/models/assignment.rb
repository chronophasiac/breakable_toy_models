class Assignment < ActiveRecord::Base
  attr_accessible :assignment_type, :instructions, :title, :url

  validates_presence_of :title 
  validates_presence_of :instructions 
  validates_presence_of :assignment_type 

  has_many  :card_prerequisites,
            inverse_of: :assignment
  has_many  :cards,
            through: :card_prerequisites,
            inverse_of: :assignments

  has_many  :courseworks,
            inverse_of: :assignment
  has_many  :users,
            through: :courseworks,
            inverse_of: :assignments

  has_many  :assignment_ratings,
            inverse_of: :assignment

  has_many  :lesson_assignments,
            inverse_of: :assignment
  has_many  :lessons,
            through: :lesson_assignments,
            inverse_of: :assignments
end
