class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :title, :body, :user_id, presence: true
  validates :title, length: 5..140
  validates :body, length: 15..1050

  accepts_nested_attributes_for :attachments

  def answer_best
    @ex_best = answers.where(best: true).first
    @ex_best ||= nil
  end

end    