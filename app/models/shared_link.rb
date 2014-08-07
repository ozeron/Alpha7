class SharedLink < ActiveRecord::Base
  belongs_to :survey, inverse_of: :shared_links
  validates_uniqueness_of :key
  after_create :create_key

  private
  def create_key
    self.key = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join)
    self.save
  end
end
