# == Schema Information
#
# Table name: card_prerequisites
#
#  id            :integer          not null, primary key
#  card_id       :integer
#  assignment_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe CardPrerequisite do
  it { should validate_presence_of(:card) }
  it { should validate_presence_of(:assignment) }

  it { should belong_to(:card) }
  it { should belong_to(:assignment) }
end
