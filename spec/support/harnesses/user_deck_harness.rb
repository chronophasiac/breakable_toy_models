module UserDeckHarness

  def associate_user_with_cards
    let(:submission)  { FactoryGirl.create(:card_submission, user: user) }
    let(:log)         { FactoryGirl.create(:card_submission_log,
                        card_submission: submission) }
    let!(:card)       { log.card }
  end

  def associate_user_with_varying_responses
    let(:submission1)  { FactoryGirl.create(:card_submission, user: user) }
    let(:submission2)  { FactoryGirl.create(:card_submission, user: user) }
    let!(:correct_submission)     { FactoryGirl.create(:card_submission_log,
                                    card_submission: submission1, correct: true) }
    let!(:incorrect_submission)  { FactoryGirl.create(:card_submission_log,
                                    card_submission: submission2, correct: false) }
  end
  
end
