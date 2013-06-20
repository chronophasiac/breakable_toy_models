require 'spec_helper'

describe Seeders::Lessons do

  let(:seeder) { Seeders::Lessons }

  it 'seeds lessons' do
    lesson_count = Lesson.count
    seeder.seed
    expect(Lesson.count).to be >(lesson_count)
  end

  it 'seeds multiple lessons' do
    lesson_count = Lesson.count
    seeder.seed(count: 3)
    expect(Lesson.count).to eql(lesson_count + 3)
  end

  it 'seeds associated assignments' do
    lessons = seeder.seed
    assignments = lessons.first.activities.where(completable_type: "Assignment")
    expect(assignments.count).to be >(0)
  end

  it 'seeds associated challenges' do
    lessons = seeder.seed
    challenges = lessons.first.activities.where(completable_type: "Challenge")
    expect(challenges.count).to be >(0)
  end

  it 'can be run multiple times without duplication' do
    seeder.seed
    lesson_count = Lesson.count
    seeder.seed
    expect(Lesson.count).to eql(lesson_count)
  end

end
