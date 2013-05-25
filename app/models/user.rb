class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  ROLES = %w[admin student]

  validates_presence_of :role
  validates_inclusion_of :role, :in => ROLES

  validates_uniqueness_of :username

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

  has_many  :challenge_progressions,
            inverse_of: :user,
            dependent: :destroy

  has_many  :challenges,
            through: :challenge_progressions,
            inverse_of: :users
end
