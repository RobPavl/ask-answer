require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }

  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  
  it { should validate_presence_of :question_id }
  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(5).is_at_most(1500) }

  describe 'mark answer as best' do

    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    it 'should mark answer as best' do
      answer.update(best: true) 
      expect(answer.best).to eq true
    end

    it 'should unmark all other answers on this question' do
      answer.mark_as_best
      other_answer = create(:answer, question: question)
      other_answer.mark_as_best
      answer.reload
      other_answer.reload

      expect(other_answer.best).to eq true
      expect(answer.best).to eq false
    end

  end

end
