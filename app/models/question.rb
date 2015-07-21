class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :body, :user_id, presence: true
  validates :title, length: 5..140
  validates :body, length: 15..1050

  def answer_best
    @ex_best = answers.where(best: true).first
    @ex_best ||= nil
  end

end    