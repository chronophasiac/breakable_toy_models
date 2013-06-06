# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)
#  role                   :string(255)      default("student"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do
  it { should validate_presence_of(:role) }
  it { should validate_uniqueness_of(:username) }

  it { should allow_value("student").for(:role) }
  it { should allow_value("admin").for(:role) }
  it { should_not allow_value("foobar").for(:role) }

  it { should have_many(:card_submissions) }
  it { should have_many(:cards) }

  it { should have_many(:courseworks) }
  it { should have_many(:assignments) }

  it { should have_many(:assignment_ratings) }

  it { should have_many(:enrollments) }
  it { should have_many(:lessons) }

  it { should have_many(:challenge_progressions) }
  it { should have_many(:challenges) }

  it "allows multiple users to be saved" do
    FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    expect(other_user).to be_valid
  end
end
