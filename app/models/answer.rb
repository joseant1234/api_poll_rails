class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :answers

  validates :description, presence: true
  validates :question, presence: true
end
