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

  User::ROLES.each do |role|
    it { should allow_value(role).for(:role) }
  end
  it { should_not allow_value("notarole").for(:role) }

  it { should have_many(:card_submissions).dependent(:destroy) }
  it { should have_many(:cards) }

  it { should have_many(:courseworks).dependent(:destroy) }
  it { should have_many(:assignments) }

  it { should have_many(:assignment_ratings).dependent(:destroy) }

  it { should have_many(:enrollments).dependent(:destroy) }
  it { should have_many(:lessons) }

  it { should have_many(:challenge_completions).dependent(:destroy) }
  it { should have_many(:challenges) }

  it "allows multiple users to be saved" do
    FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    expect(other_user).to be_valid
  end

  it "validates uniqueness of username" do
    FactoryGirl.create(:user, username: "duplicate")
    duplicate_user = FactoryGirl.build(:user, username: "duplicate")
    expect(duplicate_user.save).to be_false
    expect(duplicate_user.errors[:username]).to include("has already been taken")
  end

  context "when student" do
    let(:student) { FactoryGirl.create(:user) }

    it "returns the correct disposition of the user" do
      expect(student.superadmin?).to be_false
    end
  end

  context "when superadmin" do
    let(:superadmin) { FactoryGirl.create(:superadmin) }

    it "returns the correct disposition of the user" do
      expect(superadmin.superadmin?).to be_true
    end
  end
end
