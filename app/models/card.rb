# == Schema Information
#
# Table name: cards
#
#  id            :integer          not null, primary key
#  title         :string(255)      not null
#  instructions  :text             not null
#  problem       :text             not null
#  solution_type :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Card < ActiveRecord::Base
  has_many  :solution_positions,
            inverse_of: :card,
            dependent: :destroy
  has_many  :solution_strings,
            inverse_of: :card,
            dependent: :destroy
  has_many  :card_submissions,
            inverse_of: :card,
            dependent: :destroy
  has_many  :users,
            through: :card_submissions,
            inverse_of: :cards
  has_many  :card_prerequisites,
            inverse_of: :card,
            dependent: :destroy
  has_many  :assignments,
            through: :card_prerequisites,
            inverse_of: :cards
  has_many  :challenge_decks,
            inverse_of: :card
  has_many  :challenges,
            through: :challenge_decks,
            inverse_of: :cards

  validates_presence_of :title, :instructions, :problem, :assignments, :solution_type

  SOLUTION_TYPES = %w[position string]

  validates_inclusion_of :solution_type, :in => SOLUTION_TYPES

  attr_accessible :instructions, :problem, :snippet, :solution_type, :title

  def kind_map
    {
      "position" => "click",
      "string" =>   "type"
    }
  end

  def kind
    kind_map[solution_type]
  end

  def correct_answer?(response)
    if kind == "type"
      solution_strings.each do |solution|
        return true if solution.correct_response?(response)
      end
      return false

    elsif kind == "click"
      if response.present?
        response.each do |position|
          return false unless valid_response?(position)
        end
        return true
      else false
      end

    else
      return false
    end
  end

  def valid_response?(response)
    solution_positions.each do |solution|
      return true if solution.response_match?(response)
    end
    return false
  end

  def snippet_lines
    snippet.split(/\r\n/) 
  end

  def tokenized_snippet
    tokenized_snippet = []

    if snippet.present?
      snippet_lines.each do |line|
        Card.tokenized_line(line).each do |token|
          tokenized_snippet << {text: token}
        end
      end
    end

    tokenized_snippet
  end

  class << self
    def tokenized_line(line)
      line.split(/(\W)|(\s)/)
    end
  end

end
