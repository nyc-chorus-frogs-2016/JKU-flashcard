class Card < ActiveRecord::Base
  has_many :guesses
  belongs_to :deck

  validates :question, presence: true
  validates :answer, presence: true

end
