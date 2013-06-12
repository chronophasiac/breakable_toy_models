# == Schema Information
#
# Table name: courseworks
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  assignment_id :integer          not null
#  completed     :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Coursework < ActiveRecord::Base
  belongs_to  :user,
              inverse_of: :courseworks
  belongs_to  :assignment,
              inverse_of: :courseworks
  belongs_to  :lesson,
              inverse_of: :courseworks

  validates_presence_of :user, :assignment, :lesson

  validates_uniqueness_of :assignment_id, scope: :user_id

  attr_accessible :assignment_id, :completed, :user_id, :lesson_id
end
