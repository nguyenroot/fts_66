class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  has_many :exams, dependent: :destroy
  has_many :subjects, through: :exams
  has_many :questions, dependent: :destroy

  mount_uploader :avatar_path, PictureUploader

  enum role: {user: 0, admin: 1}

  validates :name, presence: true, length: {maximum: 50}
  validate :avatar_size

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.name = auth.info.name
        user.password = Devise.friendly_token[0, 20]
        user.provider = auth.provider
        user.uid = auth.uid
      end
    end
  end

  private
  def avatar_size
    max_size = Settings.pictures.max_size
    if avatar_path.size > max_size.megabytes
      errors.add(:avatar_path, I18n.t("pictures.error_message", max_size: max_size))
    end
  end
end
