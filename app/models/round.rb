class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :guesses
  has_many :cards, through: :guesses

  #ZM: naming conventions... finished_deck? 
  def finished_deck
    #ZM: clean this up to return true || false only. 
    #ZM: !self.deck.nil? || self.count_correct_guesses == self.deck.cards.count 

    if self.deck != nil
      self.count_correct_guesses == self.deck.cards.count
    else
      return nil
    end
  end

  #ZM: Nice work!
  def count_correct_guesses
    @correct_guesses = self.guesses.select{|guess| guess.is_correct}
    @correct_guesses.count
    #ZM: I would just make this return the collection of them rather then
    #    the count. That way I can use this method in ur correct_first method
    
  end

  #ZM: Nice work!
  def total_guesses
    @total_guesses = self.guesses
    @total_guesses.count
  end


  def count_correct_first_guesses
    #ZM: This can be reduced to this...
    #ZM guesses.group_by{|guess| guess.card_id}.select{|card_id, guesses| guesses.length == 1 }.count
    count = 0
    self.guesses.select{|guess| guess.is_correct}.each do |guess|
      if Guess.where("round_id = ? AND card_id = ?", self.id, guess.card_id).count == 1
        count += 1
      end
    end
    count
  end

  def select_random_card
    #ZM: take the correct guesses... get their id's 
    #    then remove those cards from the deck
    #    then sample them.
    #   cards_guessed_id = correct_guesses.pluck(:card_id).uniq 
    #   deck.cards.reject{|card| ids.include?(card.id) }.sample
    self.deck.cards.select {|card| card.guesses.where("round_id = ? AND is_correct = ?", self.id, true).count == 0}.sample
  end

end
