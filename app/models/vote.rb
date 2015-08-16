class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user_id, :votable_id, presence: true
  validates :votable_id, presence: true, uniqueness: { scope: [:votable_type, :user_id] }
  validates :votable_type, presence: true, inclusion: { in: ['Question', 'Answer'] }

  after_commit :change_votable_rate, on: [:create, :destroy]

  def save_score(value)
    self.score = value == 1 ? 'like' : 'dislike'
  end

  def change_votable_rate
    if self.votable.present?
      if destroyed?
        self.score == 'like' ? self.votable.decrement!(:rate, 1) : self.votable.increment!(:rate, 1)
      else
        self.score == 'like' ? self.votable.increment!(:rate, 1) : self.votable.decrement!(:rate, 1)
      end
    end
  end

end
