class CardSerializer < ActiveModel::Serializer
  attributes :id, :instructions, :title, :problem
end
