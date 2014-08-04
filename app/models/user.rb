class User < ActiveRecord::Base
  extend Enumerize

  has_one :picture
  has_many :surveys, inverse_of: :user
  has_many :answers, inverse_of: :user

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  enumerize :role, in: { user:0, admin:1 }, default: :user
  enumerize :gender, in: { male: 0, female: 1, other: 2 }, default: :other

  mount_uploader :avatar, AvatarUploader

  def full_name
    fn = "#{first_name} #{last_name}"
    return email  if fn.empty?
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
