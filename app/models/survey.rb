class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, inverse_of: :survey
  has_many :answers, :through => :questions, inverse_of: :survey
  has_many :pictures, :as => :imagealbe

  after_initialize :defaults

  def defaults
  	self.private
  end
end
