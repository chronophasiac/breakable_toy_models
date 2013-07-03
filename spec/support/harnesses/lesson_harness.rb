module LessonHarness

  def setup_lesson_and_cards_with_string_solutions
    given(:answer)      {"correctitude"}
    given(:regex)       {"^#{answer}$"}
    given!(:lesson)     { FactoryGirl.create(:lesson) }
    given!(:challenge)  { FactoryGirl.create(:challenge)}
    given!(:card1)      { FactoryGirl.create(:card_string_solution) }
    given!(:answer1)    { FactoryGirl.create(:solution_string, card: card1, regex: regex)}
    given!(:card2)      { FactoryGirl.create(:card_string_solution) }
    given!(:answer2)    { FactoryGirl.create(:solution_string, card: card2, regex: regex)}
    given!(:card3)      { FactoryGirl.create(:card_string_solution) }
    given!(:answer3)    { FactoryGirl.create(:solution_string, card: card3, regex: regex)}

    background do
      FactoryGirl.create(:challenge_deck, card: card1, challenge: challenge)
      FactoryGirl.create(:challenge_deck, card: card2, challenge: challenge)
      FactoryGirl.create(:challenge_deck, card: card3, challenge: challenge)
      FactoryGirl.create(:activity, lesson: lesson, completable: challenge)
      visit lesson_path(lesson)
      within first(".challenge") do
        click_button("Start")
      end
    end
  end

  def setup_lesson_and_cards_with_position_solutions
    given(:answer)      { {start: 0, end: 1} }
    given!(:lesson)     { FactoryGirl.create(:lesson) }
    given!(:challenge)  { FactoryGirl.create(:challenge)}
    given!(:card1)      { FactoryGirl.create(:card_position_solution) }
    given!(:answer1)    { FactoryGirl.create(:solution_position, card: card1,
                          start_position: answer[:start], end_position: answer[:end]) }

    given!(:card2)      { FactoryGirl.create(:card_position_solution) }
    given!(:answer2)    { FactoryGirl.create(:solution_position, card: card2,
                          start_position: answer[:start], end_position: answer[:end]) }

    given(:user)        { FactoryGirl.create(:user) }

    background do
      FactoryGirl.create(:challenge_deck, card: card1, challenge: challenge)
      FactoryGirl.create(:challenge_deck, card: card2, challenge: challenge)
      FactoryGirl.create(:activity, lesson: lesson, completable: challenge)
      visit lesson_path(lesson)
      within first(".challenge") do
        click_button("Start")
      end
    end
  end

end
