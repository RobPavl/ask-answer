class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user_id, :votable_id, presence: true
  validates :votable_id, presence: true, uniqueness: { scope: [:votable_type, :user_id] }
  validates :votable_type, presence: true, inclusion: { in: ['Question'] }

  def save_score(value)
    self.score = value == 1 ? 'like' : 'dislike'
  end

end
