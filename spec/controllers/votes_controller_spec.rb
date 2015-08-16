require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  let(:author) { create(:user) }
  let(:somebody) { create(:user) }
  let(:question) { create(:question, user: author) }
  let(:user_question) { create(:question, user: @user) }
  let(:vote) { create(:vote, votable: question, user: @user) }
  let!(:somebody_vote) { create(:vote, votable: question, user: somebody) }


  describe 'POST #like' do

    context 'Authenticated user' do

      sign_in_user

      it 'assign current user to a new vote' do

        post :like, votable: question.id, votable_type: 'Question', format: :json
        expect(assigns(:vote).user).to eq @user

      end

      it "assign 'like' value to score attribute" do

        post :like, votable: question.id, votable_type: 'Question', format: :json
        expect(assigns(:vote).score).to eq 'like'

      end

      it 'save new vote' do

        expect{ post :like, votable: question.id, votable_type: 'Question', format: :json }.to change(question.votes, :count).by(1)

      end

      it 'author of question has not such rights to vote for a question' do

        expect{ post :like, votable: user_question.id, votable_type: 'Question', format: :json }.to_not change(Vote, :count)

      end

      it 'current user has not ability to give a score more then one time' do

        post :like, votable: question.id, votable_type: 'Question', format: :json

        expect{ post :like, votable: question.id, votable_type: 'Question', format: :json }.to_not change(Vote, :count)
        expect(response.status).to eq 403

      end

    end

  end

  describe 'POST #dislike' do

    context 'Authenticated user' do

      sign_in_user

      it 'assign current user to a new vote' do

        post :dislike, votable: question.id, votable_type: 'Question', format: :json
        expect(assigns(:vote).user).to eq @user

      end

      it "assign 'dislike' value to score attribute" do

        post :dislike, votable: question.id, votable_type: 'Question', format: :json
        expect(assigns(:vote).score).to eq 'dislike'

      end

      it 'save new vote' do

        expect{ post :dislike, votable: question.id, votable_type: 'Question', format: :json }.to change(question.votes, :count).by(1)

      end

      it 'author of question has not such rights to vote for a question' do

        expect{ post :dislike, votable: user_question.id, votable_type: 'Question', votable_type: 'Question', format: :json }.to_not change(Vote, :count)

      end

      it 'current user has not ability to give a score more then one time' do

        post :dislike, votable: question.id, votable_type: 'Question', format: :json
        expect{ post :dislike, votable: question.id, votable_type: 'Question', format: :json }.to_not change(Vote, :count)
        expect(response.status).to eq 403

      end

    end

  end

  describe 'DELETE #cancel' do

    context 'Authenticated user' do

      sign_in_user

      it 'assigns specified vote to @vote' do

        delete :cancel, id: vote, format: :json
        expect(assigns(:vote)).to eq vote

      end

      it 'assigns specified votable to @votable' do

        delete :cancel, id: vote, format: :json
        expect(assigns(:votable)).to eq question

      end

      it 'Only owner of vote has such rights to delete his vote' do

        expect{ delete :cancel, id: vote, format: :json }.to_not change(Vote, :count)

      end

    end

  end

end