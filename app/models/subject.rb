class Subject < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :users, through: :exams

  mount_uploader :image_path, PictureUploader

  after_create :send_notify_users

  validates :name, presence: true, length: {maximum: 50}
  validates :question_number, presence: true, numericality: {only_integer: true}
  validates :duration, presence: true, numericality: {only_integer: true}
  validate :image_size

  private
  def image_size
    max_size = Settings.pictures.max_size
    if image_path.size > max_size.megabytes
      errors.add(:image_path, I18n.t("pictures.error_message", max_size: max_size))
    end
  end

  def send_notify_users
    SubjectNotification.new(self).send_notify_users
  end
end
