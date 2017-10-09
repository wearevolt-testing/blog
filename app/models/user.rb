class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  before_save :ensure_authentication_token
  before_validation :nickname_downcase

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 39 }
  validates :avatar, file_size: { less_than: 3.megabytes }

  private

  def ensure_authentication_token
    return false unless authentication_token.blank?

    self.authentication_token = generate_authentication_token
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.exists?(authentication_token: token)
    end
  end

  def nickname_downcase
    self.nickname = nickname.downcase if nickname.present?
  end
end
