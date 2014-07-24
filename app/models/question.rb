class Question < ActiveRecord::Base
  belongs_to :survey, inverse_of: :questions
  has_many :answers, inverse_of: :question
  has_many :variants, inverse_of: :question
  has_many :pictures, as: :imageable

  extend Enumerize
  enumerize :kind, in: {label:0, text:1, paragraph:2, check:3, radio:4, scale:5}

  def has_variants?
    kind.check? || kind.radio? || kind.scale?
  end
end
