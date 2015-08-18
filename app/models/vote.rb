class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :score, presence: true, inclusion: { in: [-1, 1] }
  validates :user_id, :votable_id, presence: true
  validates :votable_id, presence: true, uniqueness: { scope: [:votable_type, :user_id] }
  validates :votable_type, presence: true, inclusion: { in: ['Question', 'Answer'] }

  after_commit :change_votable_rate, on: [:create, :destroy]

  def save_score(value)
    self.score = value 
  end

  def change_votable_rate
    self.destroyed? ? self.votable.decrement!(:rate, self.score) : self.votable.increment!(:rate, self.score) if self.votable.present?
  end

end
