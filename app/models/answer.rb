class Answer < ActiveRecord::Base
  default_scope { order('best DESC') }

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, :question_id, :user_id, presence: true
  validates :body, length: 5..1500

  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }

  def mark_as_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end

end
