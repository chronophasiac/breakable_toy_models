FactoryGirl.define do
  factory :answer do
    card
    start_position  1
    end_position    2

    trait :start_equals_end do
      start_position  1
      end_position 1
    end

    trait :start_greater_than_end do
      start_position  2
      end_position 1
    end
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
    syllabus = Syllabus.new
    before(:create) do |assignment|
      lesson = FactoryGirl.create(:lesson) 
      syllabus.lesson = lesson
      syllabus.assignment = assignment
      syllabus.position = 1
      syllabus.save!
      assignment.syllabuses << syllabus
    end
    after(:create) do |assignment|
      syllabus.assignment = assignment
      syllabus.save!
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
