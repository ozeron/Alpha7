class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, inverse_of: :survey, dependent: :destroy
  has_many :answers, through: :questions, dependent: :destroy
  has_many :pictures, :as => :imagealbe
  has_one :shared_link, inverse_of: :survey, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: lambda { |h| h[:text].blank? }

  validates :title, presence: true
  validates_associated :user
  searchkick word_start: [:title]

  scope :publics, -> { where(private: false) }
  scope :privates,  -> { where(private: true)}
end
