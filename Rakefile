#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Memworks::Application.load_tasks

task :dbclean do
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed'].invoke
  Rake::Task['db:test:prepare'].invoke
end

task :dbdummy do
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Seeders::Dummy::Users.seed(count:5)
  Seeders::Dummy::Lessons.seed(count:20)
  Rake::Task['db:test:prepare'].invoke
end
