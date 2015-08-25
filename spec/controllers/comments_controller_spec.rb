require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, user: @user, question: question) }

  describe 'POST #create comment for a question' do

    sign_in_user

    context 'with valid attributes' do

      it 'assigns question to a @commentable' do
        post :create, question_id: question, commentable: 'question', comment: attributes_for(:comment), format: :json
        expect(assigns(:commentable)).to eq question
      end

      it 'assigns user created comment as an author' do
        post :create, question_id: question, commentable: 'question', comment: attributes_for(:comment), format: :json
        expect(assigns(:comment).user).to eq @user
      end

      it 'creates a comment to the question' do
        expect{ post :create, question_id: question, commentable: 'question',
            comment: attributes_for(:comment), format: :json }.to change(question.comments, :count).by(1)
      end

      it 'should respond with success' do
        post :create, question_id: question, commentable: 'question',
             comment: attributes_for(:comment), format: :json
        expect(response).to be_success
      end

    end

    context 'with invalid attributes' do

      it 'creates a comment to the question' do
        expect{ post :create, question_id: question, commentable: 'question',
                comment: attributes_for(:invalid_comment), format: :json }.to_not change(Comment, :count)
      end

      it 'should respond with success' do
        post :create, question_id: question, commentable: 'question',
             comment: attributes_for(:invalid_comment), format: :json
        expect(response).to be_unprocessable
      end

    end

  end

  describe 'POST #create comment for an answer' do

    sign_in_user

    context 'with valid attributes' do

      it 'assigns question to a @commentable' do
        post :create, answer_id: answer, commentable: 'answer',
             comment: attributes_for(:comment), format: :json
        expect(assigns(:commentable)).to eq answer
      end

      it 'assigns user created comment as an author' do
        post :create, answer_id: answer, commentable: 'answer',
             comment: attributes_for(:comment), format: :json
        expect(assigns(:comment).user).to eq @user
      end

      it 'creates a comment to the question' do
        expect{ post :create, answer_id: answer, commentable: 'answer',
                     comment: attributes_for(:comment), format: :json }.to change(answer.comments, :count).by(1)
      end

      it 'should respond with success' do
        post :create, answer_id: answer, commentable: 'answer',
             comment: attributes_for(:comment), format: :json
        expect(response).to be_success
      end

    end

    context 'with invalid attributes' do

      it 'creates a comment to the question' do
        expect{  post :create, answer_id: answer, commentable: 'answer',
                     comment: attributes_for(:invalid_comment), format: :json }.to_not change(Comment, :count)
      end

      it 'should respond with success' do
        post :create, answer_id: answer, commentable: 'answer',
             comment: attributes_for(:invalid_comment), format: :json
        expect(response).to be_unprocessable
      end

    end

  end

end
