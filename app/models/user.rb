# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)
#  role                   :string(255)      default("student"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  has_many  :card_submissions,
            inverse_of: :user,
            dependent: :destroy
  has_many  :cards,
            through: :card_submissions,
            inverse_of: :users
  has_many  :courseworks,
            inverse_of: :user,
            dependent: :destroy
  has_many  :assignments,
            through: :courseworks,
            inverse_of: :users
  has_many  :assignment_ratings,
            inverse_of: :user,
            dependent: :destroy
  has_many  :enrollments,
            inverse_of: :user,
            dependent: :destroy
  has_many  :lessons,
            through: :enrollments,
            inverse_of: :users
  has_many  :challenge_completions,
            inverse_of: :user,
            dependent: :destroy
  has_many  :challenges,
            through: :challenge_completions,
            inverse_of: :users

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

  def superadmin?
    role == "superadmin"
  end
end
