class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  
  validates :title, :body, presence: true
  validates :title, length: 5..140
  validates :body, length: 15..1050
end
