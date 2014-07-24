class Variant < ActiveRecord::Base
  belongs_to :question, inverse_of: :variants
end
