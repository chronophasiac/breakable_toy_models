class Sm2Instance
  attr_accessor :easiness_factor, :last_studied, :next_repetition,
                :number_repetitions, :quality_of_last_recall, :repetition_interval

  def initialize
    self.easiness_factor = 2.5  
    self.number_repetitions = 0  
    self.quality_of_last_recall = nil  
    self.repetition_interval = nil
    self.next_repetition = nil
    self.last_studied = nil
  end

  def log_quality_adapter(card_submission_log)
    card_submission_log.correct ? 0 : 5
  end

  def process_logs(card_submission_logs)
    card_submission_logs.each do |log|
      process_recall_result(log_quality_adapter(log), log.created_at.to_date)
    end
  end


  def process_recall_result(quality_of_recall, date = Date.today)
    ## Don't process a result if we already scored this card today
    # need to ensure we space out the results or it's spammable
    return if (self.last_studied && date == self.last_studied.to_date)
    
    if quality_of_recall < 3    
      self.number_repetitions = 0 
      self.repetition_interval = 0
    else
      self.easiness_factor = calculate_easiness_factor(easiness_factor,
                                                       quality_of_recall)
    
      if quality_of_recall == 3
        self.repetition_interval = 0
      else
        self.number_repetitions += 1

        case self.number_repetitions
        when 1
          self.repetition_interval = 1
        when 2
          self.repetition_interval = 6
        else
          self.repetition_interval = self.repetition_interval * easiness_factor
        end
      end
    end
    

    self.next_repetition = date + repetition_interval
    self.last_studied = date
    self.quality_of_last_recall = quality_of_recall
  end

  def scheduled_to_recall?(date = Date.today)
    !next_repetition.nil? && next_repetition <= date
  end

  private 
  
  def calculate_easiness_factor(easiness_factor, quality_of_recall)
    q = quality_of_recall
    ef_old = easiness_factor

    result = ef_old - 0.8 + (0.28*q) - (0.02*q*q)
    result < 1.3 ? 1.3 : result
  end
end
