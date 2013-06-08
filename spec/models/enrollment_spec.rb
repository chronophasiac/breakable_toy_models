# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  lesson_id        :integer          not null
#  last_accessed_at :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Enrollment do
  it { should validate_presence_of(:last_accessed_at) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:lesson) }

  it { should allow_value(DateTime.now).for(:last_accessed_at) }
  it { should_not allow_value(DateTime.now + 1.minute).for(:last_accessed_at) }

  it { should belong_to(:user) }
  it { should belong_to(:lesson) }
end
