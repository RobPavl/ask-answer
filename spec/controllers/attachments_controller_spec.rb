require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
let(:someone_else) { create(:user) }
let(:question) { create(:question, user: @user) }
let(:someone_else_answer) { create(:answer, user: someone_else, question: question) }
let(:attachment) { create(:attachment, attachable: question) }
let(:someone_else_attachment) { create(:attachment, attachable: someone_else_answer) }

  describe 'DELETE #destroy' do

    sign_in_user

    it 'deletes specified attachment' do

      attachment
      expect { delete :destroy, id: attachment, format: :js }.to change(question.attachments, :count).by(-1)

    end

    it 'does not delete not authors question' do

      someone_else_attachment
      expect { delete :destroy, id: someone_else_attachment, format: :js }.to_not change(Attachment, :count)

    end

    it 'redirects to index page' do
 
      delete :destroy, id: attachment, format: :js
      expect(response).to render_template :destroy

    end
  end

end