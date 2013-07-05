class CardSerializer < ActiveModel::Serializer
  attributes :id, :instructions, :title, :problem, :tokenized_snippet, :kind
  has_many :solution_strings
end
