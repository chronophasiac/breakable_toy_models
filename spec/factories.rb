FactoryGirl.define do
  factory :answer do
    card
    start_position  1
    end_position    2
  end

  factory :card do
    title         "This is a card title"
    instructions  "These are card instructions"
    problem       "This is a card problem"
    before(:create) do |card|
      card.assignments << FactoryGirl.create(:assignment)
    end
  end

  factory :assignment do
    title           "This is an assignment title"
    instructions    "These are assignment instructions"
    url             "https://thisisanassignmenturl.com"
    assignment_type "text"
    before(:create) do |assignment|
      lesson = FactoryGirl.create(:lesson) 
      l_a = LessonAssignment.new
      l_a.lesson = lesson
      l_a.assignment = assignment
      l_a.position = 1
      l_a.save!
      assignment.lesson_assignments << l_a
    end
    after(:create) do |assignment|
      l_a = assignment.lesson_assignments.last
      l_a.assignment = assignment
      l_a.save!
    end
  end

  factory :lesson do
    title "This is a lesson title"
    summary "This is a lesson summary"

    # factory :lesson_with_assignment do
    #   after(:create) do |lesson|
    #     assignment = FactoryGirl.build(:assignment)
    #     lesson_assignment = LessonAssignment.new(lesson: lesson, assignment: assignment, position: 1)
    #     lesson_assignment.save!
    #   end    
    # end

  end

end
