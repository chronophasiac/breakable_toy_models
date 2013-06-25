class ChallengeSerializer < ActiveModel::Serializer
  root(false)

  attributes :id

  has_many :cards
end
