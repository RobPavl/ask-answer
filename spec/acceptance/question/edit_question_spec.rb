require_relative '../acceptance_helper'

feature 'User edit a question' do

  given(:user) { create(:user) }
  given(:other_author) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_authors_question) { create(:question, user: other_author) }

    describe 'Authenticated user' do

      before do

        sign_in(user)
        visit question_path(question)

      end

      scenario 'edit his own question', js: true do

        within '.question' do

          click_on 'Edit'
          fill_in 'Body', with: 'It is a new body for testing'
          click_on 'Save'
          expect(page).to have_content 'It is a new body for testing'
          expect(page).to_not have_selector 'textarea#question_body'
          expect(page).to_not have_content question.body
          expect(current_path).to eq question_path(question)

        end

        within '.notice' do
          expect(page).to have_content "Question successfully updated!"
        end

      end

      scenario 'trying to edit his own question with invalid params', js: true do

        within '.question' do

          click_on 'Edit'
          fill_in 'Body', with: ''
          click_on 'Save'

          expect(page).to have_content question.body
          expect(current_path).to eq question_path(question)

          within '.question_errors' do
            expect(page).to have_content "Body can't be blank" 
            expect(page).to have_content "Body is too short (minimum is 15 characters)"
          end

        end

      end

      scenario 'trying to edit question of other author', js: true do

        visit question_path(other_authors_question)

        within '.question' do
          expect(page).to_not have_link 'Edit'
        end

      end

  end

  scenario 'Non authenticated user trying to edit question', js: true do

    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Edit'
    end

  end

end