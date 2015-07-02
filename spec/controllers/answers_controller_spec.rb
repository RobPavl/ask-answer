require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, question: question, user: @user) }
  let(:other_user) { create(:user) }
  let(:other_user_answer) { create(:answer, question: question, user: other_user) }

describe 'POST #create' do

  sign_in_user

  context 'with valid attributes' do
    it 'saves the new answer in the database' do
      expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
    end

    it 'should assign new answer to its author' do
      expect { post :create, question_id: question.id, answer: attributes_for(:answer) }
        .to change(subject.current_user.answers, :count).by(1)
    end
    
    it 'redirects to question' do
      post :create, question_id: question, answer: attributes_for(:answer)
      expect(response).to redirect_to question_path(question)
    end
  end

  context 'with invalid attributes' do
    it 'does not saves the new answer in the database' do
      expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
    end

    it 'redirects to show view' do
      post :create, question_id: question, answer: attributes_for(:invalid_answer)
      expect(response).to render_template 'questions/show'
    end
  end
end

describe 'DELETE #destroy' do

  sign_in_user

  it 'deletes specified answer' do
    answer
    expect { delete :destroy, question_id: question, id: answer }.to change(Answer, :count).by(-1)
  end
 
    it 'does not delete other user answer' do
      other_user_answer
      expect { delete :destroy, question_id: question, id: other_user_answer }.to_not change(Answer, :count)
    end

  it 'redirects to question page' do
    delete :destroy, question_id: question, id: answer
    expect(response).to redirect_to question
  end
 
end


end
