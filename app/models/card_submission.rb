class CardSubmission < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :card_submissions
  belongs_to  :user,
              inverse_of: :card_submissions
  has_many    :card_submission_logs,
              inverse_of: :card_submission,
              dependent: :destroy
  has_one     :sm2_instance,
              inverse_of: :card_submission,
              dependent: :destroy

  validates_presence_of :user, :card

  attr_accessible :card, :helpful

  class << self
    def update_submission(user, card)
      submission = user.card_submissions.where(card_id: card.id).first

      if submission.present?
        submission.touch
      else
        submission = user.card_submissions.new(card: card)
        submission.save
      end

      submission
    end
  end
  
end
