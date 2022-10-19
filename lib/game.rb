class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @letters.map { |letter| @user_guesses.include?(normalize_letter(letter)) ? letter : nil }
  end

  def lost?
    errors_allowed.zero?
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end

  def normalize_letter(letter)
    case letter
    when 'Ё' then 'Е'
    when 'Й' then 'И'
    else letter
    end
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    norm_letter = normalize_letter(letter)
    @user_guesses << norm_letter unless over? && @user_guesses.include?(norm_letter)
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
