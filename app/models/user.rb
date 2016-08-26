class User < ActiveRecord::Base
  has_many :exams, dependent: :destroy
  has_many :subjects, through: :exams

  enum role: {user: 0, admin: 1}
end
