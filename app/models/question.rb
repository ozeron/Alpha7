class Question < ActiveRecord::Base
  belongs_to :survey, inverse_of: :questions
  has_many :answers, inverse_of: :question, dependent: :destroy
  has_many :variants, inverse_of: :question, dependent: :destroy
  has_many :pictures, as: :imageable
  accepts_nested_attributes_for :variants, allow_destroy: true

  extend Enumerize
  enumerize :kind, in: { text:0, check:1, radio:2 }

  def has_variants?
    kind.check? || kind.radio?
  end

  def without_variants?
    @question_without_variants = true if text
  end
end
