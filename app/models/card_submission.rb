class CardSubmission < ActiveRecord::Base
  belongs_to  :card,
              inverse_of: :card_submissions
  belongs_to  :user,
              inverse_of: :card_submissions
  has_many    :card_submission_logs,
              inverse_of: :card_submission,
              dependent: :destroy

  validates_presence_of :user, :card

  attr_accessible :card, :helpful

  def sm2_next_repetition
    sm2 = Sm2Instance.new
    card_submission_logs.find_each do |log|
      sm2.process_log(log)
    end
    sm2.next_repetition
  end

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

    def by_next_repetition(user)
      #TODO this shouldn't be an in-memory sort operation
      user.card_submissions.sort_by(&:sm2_next_repetition)
    end
  end
  
end
