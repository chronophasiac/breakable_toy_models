class MyDeck

  def initialize(user)
    @user = user
  end

  def cards
    submissions = CardSubmission.by_next_repetition(@user)
    submissions.map(&:card)
  end
  
end
