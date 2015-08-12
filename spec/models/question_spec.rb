require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }

  it { should have_many(:answers).dependent(:destroy) }

  it { should have_many(:attachments).dependent(:destroy) }
  it { should accept_nested_attributes_for(:attachments) }

  it { should have_many(:votes).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:title).is_at_least(5).is_at_most(140) }
  it { should validate_length_of(:body).is_at_least(15).is_at_most(1050) }

  describe 'find best answer' do

  	let(:question) { create(:question) }
    let(:answer) { create(:answer, best: true, question: question) }

    it 'should return existing best answer in question' do
        question.answer_best
    	expect(answer.best).to_not be nil
    end

  end

  describe 'could not find best answer' do

    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    it 'would not return nonexisting best answer in question' do
      question.answer_best
    	expect(answer.best).to_not be 
    end

  end

 end
