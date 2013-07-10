class User < ActiveRecord::Base
  has_many  :card_submissions,
            inverse_of: :user,
            dependent: :destroy
  has_many  :card_submission_logs,
            through: :card_submissions,
            inverse_of: :user,
            readonly: true
  has_many  :cards,
            through: :card_submissions,
            inverse_of: :users,
            readonly: true
  has_many  :courseworks,
            inverse_of: :user,
            dependent: :destroy
  has_many  :assignments,
            through: :courseworks,
            inverse_of: :users,
            readonly: true
  has_many  :assignment_ratings,
            inverse_of: :user,
            dependent: :destroy
  has_many  :enrollments,
            inverse_of: :user,
            dependent: :destroy
  has_many  :lessons,
            through: :enrollments,
            inverse_of: :users,
            readonly: true
  has_many  :challenge_completions,
            inverse_of: :user,
            dependent: :destroy
  has_many  :challenges,
            through: :challenge_completions,
            inverse_of: :users,
            readonly: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  ROLES = %w[superadmin student]

  validates_presence_of  :role
  validates_inclusion_of :role, in: ROLES

  validates_uniqueness_of :username, allow_blank: true

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  def assignment_progress(assignment)
    courseworks.where(assignment_id: assignment.id).first
  end

  def lesson_completed?(lesson)
    myLesson = lessons.where(id: lesson.id).first
    if myLesson.present?
      myLesson.activities.each do |activity|
        if activity.completable_type == "Assignment"
          coursework = courseworks.where(assignment_id: activity.completable.id).first
          if coursework.present?
            return false unless coursework.completed
          else return false
          end
        elsif activity.completable_type == "Challenge"
          return false unless challenges.include?(activity.completable)
        end
      end
      return true
    else return false
    end
  end

  def superadmin?
    role == "superadmin"
  end

  def has_cards?
    card_submissions.length > 0
  end
end
