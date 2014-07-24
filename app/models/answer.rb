class Answer < ActiveRecord::Base
  belongs_to :question, inverse_of: :answers
  belongs_to :answerer, class_name: User, inverse_of: :answers
end
