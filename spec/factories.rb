FactoryGirl.define do
  factory :activity do
    lesson
    association :completable, factory: :assignment
    position 1
  end
  
  factory :assignment do
    sequence(:title)  { |n| "This is a #{n} assignment title" }
    summary           "This is an assignment summary"
    instructions      "These are assignment instructions"
    url               "https://thisisanassignmenturl.com"
    assignment_type   "text"
  end

  factory :card_position_solution, class: Card do
    title         "This is a card title"
    instructions  "These are card instructions"
    problem       "This is a card problem"
    solution_type "position"

    before(:create) do |card|
      card.assignments << FactoryGirl.create(:assignment)
      card.solution_strings << FactoryGirl.create(:solution_string, card: card)
    end
  end

  factory :card_string_solution, class: Card do
    title         "This is a card title"
    instructions  "These are card instructions"
    problem       "This is a card problem"
    solution_type "string"

    before(:create) do |card|
      card.assignments << FactoryGirl.create(:assignment)
      card.solution_positions << FactoryGirl.create(:solution_position, card: card)
    end
  end

  factory :card_submission do
    user
    association :card, factory: :card_position_solution
  end

  factory :card_submission_log do
    correct         true
    time_taken      30
    card_submission
  end

  factory :challenge do
    title         "This is a challenge title"
  end

  factory :challenge_deck do
    association :card, factory: :card_position_solution
    challenge
  end

  factory :coursework do
    user
    assignment
    lesson
  end

  factory :enrollment do
    user
    lesson
    last_accessed_at DateTime.now
  end

  factory :lesson do
    sequence(:title)  { |n| "This is a #{n} lesson title" }
    summary           "This is a lesson summary"
  end

  factory :solution_position do
    association :card, factory: :card_position_solution
    start_position  1
    end_position    2
  end

  factory :solution_string do
    association :card, factory: :card_string_solution
    regex "foo"
  end

  factory :user do
    sequence(:email)      {|n| "email#{n}@memworks.com" }
    password              "123qweasd"
    password_confirmation "123qweasd"
    confirmed_at          DateTime.now
    factory :superadmin do
      role                "superadmin"
    end
  end

end
