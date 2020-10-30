class Game < ApplicationRecord
  belongs_to :user
  has_many :questions, through: :game_questions
end
