class Answer < ActiveRecord::Base
  belongs_to :response, inverse_of: :answers
  belongs_to :question, inverse_of: :answers
  validates :text, presence: :true
end
