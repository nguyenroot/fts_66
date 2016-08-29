class Subject < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :users, through: :exams

  validates :name, presence: true, length: {maximum: 50}
  validates :question_number, presence: true, numericality: {only_integer: true}
  validates :duration, presence: true, numericality: {only_integer: true}
end
