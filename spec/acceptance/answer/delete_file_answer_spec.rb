require_relative '../acceptance_helper'

feature 'User deletes a file from created answer' do

    given(:user) { create(:user) }
    given(:question) { create(:question, user: user) }
    given(:answer) { create(:answer, user: user, question: question) }
    given!(:attachment) { create(:attachment, attachable: answer) }

  describe 'Authenticated user' do

    background do
      sign_in user
      visit question_path(question)
    end

    scenario 'User deletes a file from created answer', js: true do


      within '.answers' do

        click_on 'Remove file'

        expect(page).to_not have_link 'Remove file'
        expect(page).to_not have_content attachment.file.file.filename

      end

    end

  end
  
  scenario 'Not author does not has such rights to delete file', js: true do

    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Remove file'
      expect(page).to have_content attachment.file.file.filename
    end

  end

end