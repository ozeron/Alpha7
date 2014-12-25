class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, inverse_of: :survey, dependent: :destroy
  has_many :responses, inverse_of: :survey, dependent: :destroy
  has_many :answers, through: :responses, dependent: :destroy
  has_many :pictures, :as => :imagealbe
  has_one :shared_link, inverse_of: :survey, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: lambda { |h| h[:text].blank? }

  validates :title, presence: true
  validates :title, length: {maximum: 255}
  validates_associated :user
  searchkick word_start: [:title]
  validates  :questions, length: { minimum: 1 }
  scope :publics, -> { where(private: false) }
  scope :privates,  -> { where(private: true)}


end
