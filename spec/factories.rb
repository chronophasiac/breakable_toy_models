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
    sequence(:title)  { |n| "This is a #{n} card title" }
    instructions      "These are card instructions"
    problem           "This is a card problem"
    snippet           %Q{
class Activity < ActiveRecord::Base
  belongs_to  :completable,
              polymorphic: true,
              inverse_of: :activities

  class << self
    def descending_position
      order('position')
    end
  end
end
}
    solution_type     "position"

    before(:create) do |card|
      card.assignments << FactoryGirl.create(:assignment)
      card.solution_positions << FactoryGirl.create(:solution_position, card: card)
    end
  end

  factory :card_string_solution, class: Card do
    sequence(:title)  { |n| "This is a #{n} card title" }
    instructions      "These are card instructions"
    problem           "This is a card problem"
    solution_type     "string"

    before(:create) do |card|
      card.assignments << FactoryGirl.create(:assignment)
      card.solution_strings << FactoryGirl.create(:solution_string, card: card)
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
    sequence(:title)  { |n| "This is a #{n} challenge title" }
  end

  factory :challenge_deck do
    association :card, factory: :card_string_solution
    challenge

    trait :position do
      association :card, factory: :card_position_solution
    end
    
    factory :challenge_deck_position_solution, traits: [:position]
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
    regex "^correct answer$"
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
