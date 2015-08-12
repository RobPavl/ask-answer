class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :title, :body, :user_id, presence: true
  validates :title, length: 5..140
  validates :body, length: 15..1050

  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }

  def answer_best
    @ex_best = answers.where(best: true).first
  end

end    