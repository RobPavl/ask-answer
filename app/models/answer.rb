class Answer < ActiveRecord::Base
  default_scope { order('best DESC') }

  belongs_to :question
  belongs_to :user
  
  validates :body, :question_id, :user_id, presence: true
  validates :body, length: 5..1500

  def mark_as_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end

end
