class Dashboard
  def initialize(user)
    @user = user
  end

  def completed_challenges
    @user.challenge_completions.includes(:challenge).order("updated_at DESC").limit(5)
  end

  def lessons_in_progress
    lessons_in_progress = []

    @user.lessons.find_each do |lesson|
      lessons_in_progress << lesson unless @user.lesson_completed?(lesson)
    end

    lessons_in_progress[0..4]
  end

  def assignments_in_progress
    @user.courseworks.where(completed: false).includes(:assignment).order("updated_at DESC").limit(5)
  end

  def completed_assignments
    @user.courseworks.where(completed: true).includes(:assignment).order("updated_at DESC").limit(5)
  end

  def card_queue
    submissions = CardSubmission.by_next_repetition(@user)
    submissions[0..9]
  end
end
