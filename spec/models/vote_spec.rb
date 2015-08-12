require 'rails_helper'

RSpec.describe Vote, type: :model do

  let(:author) { create(:user) }
  let(:question) { create(:question, user: author) }
  let(:vote) { build(:vote, votable: question, user: author) }

  it { should belong_to :user }
  it { should validate_presence_of :user_id }

  it { should belong_to :votable }
  it { should validate_presence_of :votable_id }
  it { should validate_presence_of :votable_type }
  it { should validate_inclusion_of(:votable_type).in_array([:Question]) }

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

end