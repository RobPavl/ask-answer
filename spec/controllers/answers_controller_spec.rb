require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, question: question, user: @user) }
  let(:current_best_answer) { create(:answer, question: question, user: @user) }
  let(:other_user) { create(:user) }
  let(:other_user_question) { create(:question, user: other_user) }
  let(:other_user_answer) { create(:answer, question: other_user_question, user: other_user) }

describe 'POST #best' do

  sign_in_user

  context 'Author' do

    before { post :best, id: answer, format: :js }

    it 'marks answer as best' do
      answer.reload
      expect(answer.best).to eq true
    end

    it 'assigns ex-best answer' do
      post :best, id: current_best_answer, format: :js
      expect(assigns(:ex_best)).to eq answer 
    end

    it 'renders update page' do
      expect(response).to render_template :best
    end

  end

  context 'Not author' do

    it 'Not author of question has not such rights to mark answer as best' do
      post :best, id: other_user_answer, format: :js
      expect(other_user_answer.best).to_not eq true
    end

  end

end

describe 'POST #create' do

  sign_in_user

  context 'with valid attributes' do
    it 'saves the new answer in the database' do
      expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(question.answers, :count).by(1)
    end

    it 'should assign new answer to its author' do
      expect { post :create, question_id: question.id, answer: attributes_for(:answer), format: :js }
        .to change(subject.current_user.answers, :count).by(1)
    end
    
    it 'redirects to question' do
      post :create, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :create
     end
  end

  context 'with invalid attributes' do
    it 'does not saves the new answer in the database' do
      expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
    end

    it 'redirects to show view' do
      post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
      expect(response).to render_template :create
    end
  end
end

describe 'PATCH #update' do
 
     sign_in_user
 
     context 'with valid attributes' do
 
      before { patch :update, id: answer, answer: { body: 'Updated_body_answer' }, format: :js }
 
       it 'assigns specified answer to @answer' do
         expect(assigns(:answer)).to eq answer
       end
 
       it 'saves specified answer with received attributes' do
 
         answer.reload
         expect(answer.body).to eq 'Updated_body_answer'
 
       end
 
       it 'redirects to question' do
        expect(response).to render_template :update
       end
 
     end
 
     context 'with invalid attributes' do
 
      before { patch :update, id: answer, answer: attributes_for(:answer), format: :js }
 
       it 'does not saves specified answer with received attributes' do
 
         answer.reload
         expect(answer.body).to_not eq attributes_for(:invalid_question)[:body]
 
         expect(answer.body).to eq answer.body
 
       end
 
       it 'rerenders edit page' do
        expect(response).to render_template :update
       end
 
     end
 
    context do

      it 'does not update answer with another author' do

        old_value = other_user_answer.body

        patch :update, id: other_user_answer, answer: { body: 'Edited body' }, format: :js

        other_user_answer.reload

        expect(other_user_answer.body).to_not eq 'Edited body'
        expect(other_user_answer.body).to eq old_value

      end
    end

   end

describe 'DELETE #destroy' do

  sign_in_user

  it 'deletes specified answer' do
    answer
    expect { delete :destroy, id: answer, format: :js }.to change(Answer, :count).by(-1)
  end
 
    it 'does not delete other user answer' do
      other_user_answer
      expect { delete :destroy, id: other_user_answer, format: :js}.to_not change(Answer, :count)
    end

  it 'redirects to question page' do
    delete :destroy, id: answer, format: :js
    expect(response).to render_template :destroy
  end
 
end


end
