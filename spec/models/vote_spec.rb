require 'rails_helper'

RSpec.describe Vote, type: :model do

  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:one_more_user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question, user: author) }
  let(:vote) { build(:vote, votable: question, user: user) }
  let(:vote_2) { create(:vote, votable: question, user: one_more_user) }
  let(:vote_3) { create(:dislike_vote, votable: question, user: another_user) }

  it { should belong_to :user }
  it { should validate_presence_of :user_id }

  it { should belong_to :votable }
  it { should validate_presence_of :votable_id }
  it { should validate_uniqueness_of(:votable_id).scoped_to([:votable_type,:user_id]) }
  it { should validate_presence_of :votable_type }
  it { should validate_inclusion_of(:votable_type).in_array([:Question, :Answer]) }

  it "save to score 'like'/'dislike' value according to call params " do

    vote.save_score(1)

    expect(vote.score).to eq 'like'

    vote.save_score(-1)

    expect(vote.score).to eq 'dislike'

  end

  it 'do not save to score attribute value when call params was not in specified range' do

    vote.save_score(0)

    expect(vote.score).to eq 'dislike'

  end

  it 'changes rate of votable model after one more vote' do
    vote_2
    question.reload
    expect(question.rate).to eq 1
    vote_3
    question.reload
    expect(question.rate).to eq 0
  end

end