class PredictionService
  attr_reader :prediction_term

  def initialize(prediction_term=Rails.configuration.x.prediction_word)
    @prediction_term = prediction_term
    @errors = ErrorHash.new
    @value = nil
  end

  def call(team_string:)
    clear!
    validate_team_string_format(team_string)
    return result unless @errors.empty?

    occurances = find_prediction_term_occurences(team_string)
    num_string = build_num_string(occurances)
    @value = calculate_percentage(num_string)
    result
  end

  private
    def clear!
      @errors.clear
      @value = nil
    end

    def result
      ServiceResultFactory.from_value_and_errors(@value, @errors)
    end

    def validate_team_string_format(team_string)
      # NOTE: This is a crude Regex - Not sutable for production ready
      unless team_string =~ /.*\S*\s?[&]\s?\S*.*/
        @errors.add(:format, 'Invalid team name format. Example format: "First Name & Second Name"')
      end
    end

    def find_prediction_term_occurences(string)
      @prediction_term.upcase.chars.reduce([]) do |occurences, char|
        count = string.upcase.count(char)
        occurences << count
      end
    end

    def build_num_string(array)
      array.reduce('') { |num_str, num| num_str + num.to_s }
    end

    def calculate_percentage(num_str)
      new_array = []
      num_str.chars.each_cons(2) do |element, next_element|
        new_array << (element.to_i + next_element.to_i)
      end
      new_num_string = build_num_string(new_array)
      return new_num_string if (new_num_string.to_i < 100)
      calculate_percentage(new_num_string)
    end
end
