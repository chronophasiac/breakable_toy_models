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
            inverse_of: :cards,
            readonly: true
  has_many  :card_submission_logs,
            through: :card_submissions,
            inverse_of: :card,
            readonly: true
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

  def tokenizer
    snippet.split(/(\W)|(\s)/)
  end

  def tokenized_snippet
    tokenized_snippet = []

    if snippet.present?
      tokenizer.each_with_index do |token, index|
        solution = correct_answer?([{position: index}])
        tokenized_snippet << {text: token, solution: solution}
      end
    end

    tokenized_snippet
  end

  def canonical_solution
    solution = ""

    if kind == "type"
      solution = solution_strings.first.regex
      solution.slice!(0)
      solution.slice!(solution.length-1)
    end

    solution
  end

end
