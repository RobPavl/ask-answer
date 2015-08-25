require_relative '../acceptance_helper'

feature 'User edits answer' do

  given(:user) { create(:user) }
  given(:other_author) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:other_author_answer) { create(:answer, user: other_author, question: question) }

  describe 'Authenticated user' do

    before do

      sign_in user
      visit question_path(question)

    end

    scenario 'edits his answer with valid params', js: true do

      within "#answer-#{answer.id}" do

        click_on 'Edit'
        fill_in 'Body', with: 'Edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea#answer_body'

      end

      within '.notice' do
        expect(page).to have_content 'Answer successfully updated!'
      end

    end

    scenario 'edits his answer with invalid params', js: true do

      within "#answer-#{answer.id}" do

        click_on 'Edit'
        fill_in 'Body', with: ''
        click_on 'Save'
        
        expect(page).to have_content answer.body
        expect(page).to have_content "Body is too short (minimum is 5 characters)"
        expect(page).to have_content "Body can't be blank"

      end

    end

    scenario 'trying to edit not his answer', js: true do

      within "#answer-#{other_author_answer.id}" do
        expect(page).to_not have_link 'Edit'
      end

    end

  end

end