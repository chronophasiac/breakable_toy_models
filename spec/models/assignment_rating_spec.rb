# == Schema Information
#
# Table name: assignment_ratings
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  assignment_id :integer          not null
#  helpful       :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe AssignmentRating do
  it { should validate_presence_of(:helpful) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:assignment) }

  it { should belong_to(:user) }
  it { should belong_to(:assignment) }
end
