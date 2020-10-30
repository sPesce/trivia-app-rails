class Question < ApplicationRecord
  has_many :answers
  has_many :user_questions
end
