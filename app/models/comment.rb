class Comment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true

  belongs_to :user

  validates :user_id, :commentable_id, presence: true

  validates :commentable_type, presence: true, inclusion: { in: ['Answer','Question'] }

  validates :body, presence: true, length: { minimum: 5, maximum: 1000 }

end

