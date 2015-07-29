require_relative '../acceptance_helper'

feature 'User deletes a file from created question' do

  describe 'Authenticated user' do

    given(:user) { create(:user) }
    given(:question) { create(:question, user: user) }
    given!(:attachment) { create(:attachment, attachable: question) }

    background do
      sign_in user
      visit question_path(question)
    end

    scenario 'User deletes a file from created question', js: true do


      within '.question' do

        click_on 'Remove file'

        expect(page).to_not have_link 'Remove file'
        expect(page).to_not have_content attachment.file.file.filename

      end

    end

  end

end