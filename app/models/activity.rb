class Activity < ActiveRecord::Base
  belongs_to  :completable,
              polymorphic: true,
              inverse_of: :activities
  belongs_to  :lesson,
              inverse_of: :activities

  validates_presence_of :completable, :completable_type, :lesson, :position

  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  validates_uniqueness_of :position, scope: :lesson_id

  attr_accessible :completable_id, :position

  class << self
    def descending_position
      order('position')
    end
  end
end
