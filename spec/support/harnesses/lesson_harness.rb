module LessonHarness

  def setup_lesson_and_cards_with_string_solutions
    given(:answer)      {"correctitude"}
    given(:regex)       {"^#{answer}$"}
    given(:lesson)     { FactoryGirl.create(:lesson) }
    given(:challenge)  { FactoryGirl.create(:challenge)}
    given(:card1)      { FactoryGirl.create(:card_string_solution) }
    given(:answer1)    { card1.solution_strings.first }
    given(:card2)      { FactoryGirl.create(:card_string_solution) }
  end

  def associate_string_solution_cards_with_challenge_and_init
    answer1.regex = regex
    answer1.save
    FactoryGirl.create(:challenge_deck, card: card1, challenge: challenge)
    FactoryGirl.create(:challenge_deck, card: card2, challenge: challenge)
    FactoryGirl.create(:activity, lesson: lesson, completable: challenge)
    visit lesson_path(lesson)
    within first(".challenge") do
      click_button("Start")
    end
  end

  def setup_lesson_and_cards_with_position_solutions
    given(:answer)      { {start: 0, end: 2} }
    given(:snippet)     { "Test code snippet goes here." }
    given(:lesson)      { FactoryGirl.create(:lesson) }
    given(:challenge)   { FactoryGirl.create(:challenge)}
    given(:card1)       { FactoryGirl.create(:card_position_solution, snippet: snippet) }
    given(:answer1)     { card1.solution_positions.first }
    given(:card2)       { FactoryGirl.create(:card_position_solution) }
    given(:correct_ID)  { "#position#{answer[:end]}" }
    given(:wrong_ID)    { "#position#{answer[:end] + 1}" }
  end

  def associate_position_solution_cards_with_challenge_and_init
    answer1.start_position = answer[:start]
    answer1.end_position = answer[:end]
    answer1.save
    FactoryGirl.create(:challenge_deck, card: card1, challenge: challenge)
    FactoryGirl.create(:challenge_deck, card: card2, challenge: challenge)
    FactoryGirl.create(:activity, lesson: lesson, completable: challenge)
    visit lesson_path(lesson)
    within first(".challenge") do
      click_button("Start")
    end
  end

  def setup_lesson_and_cards_with_mixed_solutions
    given(:string_answer)   {"correctitude"}
    given(:regex)           {"^#{string_answer}$"}
    given(:position_answer) { {start: 0, end: 1} }
    given(:snippet)         { "Test code snippet goes here." }
    given(:lesson)          { FactoryGirl.create(:lesson) }
    given(:challenge)       { FactoryGirl.create(:challenge)}
    given(:card1)           { FactoryGirl.create(:card_position_solution, snippet: snippet) }
    given(:answer1)         { card1.solution_positions.first }
    given(:card2)           { FactoryGirl.create(:card_string_solution) }
    given(:answer2)         { card2.solution_strings.first }
    given(:correct_ID)      { "#position#{position_answer[:end]}" }
    given(:wrong_ID)        { "#position#{position_answer[:end] + 1}" }
  end

  def associate_mixed_solution_cards_with_challenge_and_init
    answer1.start_position = position_answer[:start]
    answer1.end_position = position_answer[:end]
    answer1.save
    answer2.regex = regex
    answer2.save
    FactoryGirl.create(:challenge_deck, card: card1, challenge: challenge)
    FactoryGirl.create(:challenge_deck, card: card2, challenge: challenge)
    FactoryGirl.create(:activity, lesson: lesson, completable: challenge)
    visit lesson_path(lesson)
    within first(".challenge") do
      click_button("Start")
    end
  end

end
