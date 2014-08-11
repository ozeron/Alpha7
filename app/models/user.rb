require 'file_size_validator'

class User < ActiveRecord::Base
  extend Enumerize

  has_one :picture
  has_many :surveys, inverse_of: :user, dependent: :destroy
  has_many :answers, inverse_of: :user
  accepts_nested_attributes_for :answers, allow_destroy: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerize :role, in: { user:0, admin:1 }, default: :user
  enumerize :gender, in: { male: 0, female: 1, other: 2 }, default: :other

  mount_uploader :avatar, AvatarUploader

  validates :first_name, :last_name,
            format: { with: /\A[A-Za-z\D]+\z/ },
            length: { maximum: 255 },
            allow_blank: true
  validates :avatar, file_size: { maximum: 2.megabytes.to_i }
  validates :birthday, format: { with: /\A[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])+\z/ }, allow_blank: true

  def full_name
    fn = "#{first_name} #{last_name}"
    return email  if fn.blank?
    fn.lstrip.rstrip
  end

  def admin
    role.admin?
  end

  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

end
