class Response < ActiveRecord::Base
  belongs_to :survey, inverse_of: :responses
  belongs_to :answerer, class_name: User, inverse_of: :responses
  has_many :answers, inverse_of: :response, dependent: :destroy
  validates_associated :answers
  validates_associated :answerer
  validates_associated :survey
end
