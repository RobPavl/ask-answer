require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  let(:author) { create(:user) }
  let(:question) { create(:question, user: author) }
  let(:user_question) { create(:question, user: @user) }
  let(:vote) { create(:vote, votable: question, user: author) }


  describe 'POST #like' do

    context 'Authenticated user' do

      sign_in_user

      it 'assign current user to a new vote' do

        post :like, question: question.id, format: :json
        expect(assigns(:vote).user).to eq @user

      end

      it "assign 'like' value to score attribute" do

        post :like, question: question.id, format: :json
        expect(assigns(:vote).score).to eq 'like'

      end

      it 'save new vote' do

        expect{ post :like, question: question.id, format: :json }.to change(question.votes, :count).by(1)

      end

      it 'author of question has not such rights to vote for a question' do

        expect{ post :like, question: user_question.id, format: :json }.to_not change(Vote, :count)

      end

      it 'current user has not ability to give a score more then one time' do

        post :like, question: question.id, format: :json

        expect{ post :like, question: question.id, format: :json }.to_not change(Vote, :count)
        expect(response.status).to eq 403

      end

    end

  end

  describe 'POST #dislike' do

    context 'Authenticated user' do

      sign_in_user

      it 'assign current user to a new vote' do

        post :dislike, question: question.id, format: :json
        expect(assigns(:vote).user).to eq @user

      end

      it "assign 'dislike' value to score attribute" do

        post :dislike, question: question.id, format: :json
        expect(assigns(:vote).score).to eq 'dislike'

      end

      it 'save new vote' do

        expect{ post :dislike, question: question.id, format: :json }.to change(question.votes, :count).by(1)

      end

      it 'author of question has not such rights to vote for a question' do

        expect{ post :dislike, question: user_question.id, format: :json }.to_not change(Vote, :count)

      end

      it 'current user has not ability to give a score more then one time' do

        post :dislike, question: question.id, format: :json
        expect{ post :dislike, question: question.id, format: :json }.to_not change(Vote, :count)
        expect(response.status).to eq 403

      end

    end

  end

end