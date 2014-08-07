class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, inverse_of: :survey
  has_many :answers, :through => :questions, inverse_of: :survey
  has_many :pictures, :as => :imagealbe
  has_many :shared_links, inverse_of: :survey
  validates :title, presence: true
  validates_associated :user
  searchkick word_start: [:title]

  scope :publics, -> { where(private: false) }
  scope :privates,  -> { where(private: true)}
end
