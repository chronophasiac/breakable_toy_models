require 'spec_helper'

describe Seeders::Dummy::Users do

  let(:seeder) { Seeders::Dummy::Users }

  it 'seeds users' do
    user_count = User.count
    seeder.seed
    expect(User.count).to be >(user_count)
  end

  it 'seeds multiple users' do
    user_count = User.count
    seeder.seed(count: 3)
    expect(User.count).to eql(user_count + 3)
  end

  it 'seeds one superadmin' do
    seeder.seed(count: 4)
    expect(User.first.role).to eql("superadmin")
  end

  it 'seeds students' do
    seeder.seed(count: 4)
    User.first.destroy
    User.all.each do |user|
      expect(user.role).to eql("student")
    end
  end

  it 'can be run multiple times without duplication' do
    seeder.seed
    user_count = User.count
    seeder.seed
    expect(User.count).to eql(user_count)
  end
end
