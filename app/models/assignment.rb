class Assignment < ActiveRecord::Base
  has_many  :card_prerequisites,
            inverse_of: :assignment,
            dependent: :destroy
  has_many  :cards,
            through: :card_prerequisites,
            inverse_of: :assignments
  has_many  :courseworks,
            inverse_of: :assignment,
            dependent: :destroy
  has_many  :users,
            through: :courseworks,
            inverse_of: :assignments
  has_many  :assignment_ratings,
            inverse_of: :assignment,
            dependent: :destroy
  has_many  :activities,
            as: :completable,
            dependent: :destroy
  has_many  :lessons,
            through: :activities

  validates_presence_of :title, :instructions, :assignment_type, :summary

  validates :url, :url => { allow_blank: true }

  ASSIGNMENT_TYPE = %w[text audio video]

  validates_inclusion_of :assignment_type, :in => ASSIGNMENT_TYPE

  attr_accessible :assignment_type, :instructions, :summary, :title, :url
end
