class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  #status should initialize to 0
  after_initialize{|usr_q| usr_q.status ||= 0}
end
