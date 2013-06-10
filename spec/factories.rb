FactoryGirl.define do
  factory :activity do
    lesson
    association :completable, factory: :assignment
    position 1
  end
  
  factory :solution_index do
    card
    start_index  1
    end_index    2
  end

  factory :assignment do
    sequence(:title)  { |n| "This is a #{n} assignment title" }
    instructions      "These are assignment instructions"
    url               "https://thisisanassignmenturl.com"
    assignment_type   "text"
  end

  factory :card do
    title         "This is a card title"
    instructions  "These are card instructions"
    problem       "This is a card problem"
    before(:create) do |card|
      card.assignments << FactoryGirl.create(:assignment)
    end
  end

  factory :card_submission do
    user
    card
  end

  factory :card_submission_log do
    correct         true
    time_taken      30
    card_submission
  end

  factory :challenge do
    title         "This is a challenge title"
  end

  factory :lesson do
    sequence(:title)  { |n| "This is a #{n} lesson title" }
    summary           "This is a lesson summary"
  end

  factory :user do
    sequence(:email)      {|n| "email#{n}@example.com" }
    password              "password"
    password_confirmation "password"
  end

end
