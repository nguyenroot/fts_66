class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :exams, dependent: :destroy
  has_many :subjects, through: :exams

  enum role: {user: 0, admin: 1}

  validates :name, presence: true, length: {maximum: 50}
  validates :chatwork_id, presence: true, length: {maximum: 50}
end
