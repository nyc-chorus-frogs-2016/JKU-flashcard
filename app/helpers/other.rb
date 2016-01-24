def answered_correctly(round_id, card_id)
  Guess.where("round_id = ? AND card_id = ? AND is_correct = ?", round_id, card_id, true).count == 1
end