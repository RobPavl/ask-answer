require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:question) { create(:question, user: @user) }

  describe 'POST #create' do

    sign_in_user

    context 'with valid attributes' do

      it 'assigns question to a @commentable' do
        post :create, question_id: question, comment: attributes_for(:comment)
        expect(assigns(:commentable)).to eq question
      end

      it 'assigns user created comment as an author' do
        post :create, question_id: question, comment: attributes_for(:comment)
        expect(assigns(:comment).user).to eq @user
      end

      it 'creates a comment to the question' do
        expect{ post :create, question_id: question, comment: attributes_for(:comment) }.to change(question.comments, :count)
      end

    end

  end

end
