class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, inverse_of: :survey
  has_many :answers, :through => :questions, inverse_of: :survey
  has_many :pictures, :as => :imagealbe

  searchkick word_start: [:title]

  scope :publics, -> { where(private: false) }

end
