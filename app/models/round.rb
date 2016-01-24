class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :guesses
  has_many :cards, through: :guesses

  def finished_deck
    if self.deck != nil
      self.count_correct_guesses == self.deck.cards.count
    else
      return nil
    end
  end

  def count_correct_guesses
    @correct_guesses = self.guesses.select{|guess| guess.is_correct}
    @correct_guesses.count
  end

  def total_guesses
    @total_guesses = self.guesses
    @total_guesses.count
  end

  def count_correct_first_guesses
    count = 0
    self.guesses.select{|guess| guess.is_correct}.each do |guess|
      if Guess.where("round_id = ? AND card_id = ?", self.id, guess.card_id).count == 1
        count += 1
      end
    end
    count
  end

  def select_random_card
    self.deck.cards.select {|card| card.guesses.where("round_id = ? AND is_correct = ?", self.id, true).count == 0}.sample
  end

end
