# == Schema Information
#
# Table name: card_submissions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  card_id    :integer          not null
#  helpful    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe CardSubmission do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:card) }

  it { should belong_to(:user) }
  it { should belong_to(:card) }
  it { should have_many(:card_submission_logs).dependent(:destroy) }
end
