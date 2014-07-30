class User < ActiveRecord::Base
  extend Enumerize

  has_one :picture
  has_many :surveys, inverse_of: :user
  has_many :answers, inverse_of: :user

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  enumerize :role, in: [:user, :admin], default: :user
  enumerize :gender, in: {male: 0, female: 1, other: 2}

  mount_uploader :avatar, AvatarUploader
end
