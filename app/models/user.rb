class User < ApplicationRecord
  has_many :scores
  has_many :user_questions
  has_many :questions, through: :user_questions
end
# Question.where('id NOT IN (SELECT DISTINCT(question_id) FROM game_questions)')

# Question.includes(:game_questions).where('game_questions < ?', 2)

# questions = 
# Question.includes(:game_questions).where('game_questions < ?', 2).or(
# Question.where('id NOT IN (SELECT DISTINCT(question_id) FROM game_questions)'))