module UserDeckHarness

  def associate_user_with_cards
    let(:submission)  { FactoryGirl.create(:card_submission, user: user) }
    let(:log)         { FactoryGirl.create(:card_submission_log,
                        card_submission: submission) }
    let!(:card)       { log.card }
  end
  
end
