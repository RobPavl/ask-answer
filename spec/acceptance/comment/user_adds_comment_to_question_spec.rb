require_relative '../acceptance_helper'

feature 'User adds comment to question' do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe 'Authenticated user' do

    background do
      sign_in user
      visit question_path(question)
    end

    scenario 'adds a comment to the question', js: true do

      within '.question' do

        fill_in 'Add a comment', with: attributes_for(:comment)[:body]

         expect(page).to have_content attributes_for(:comment)[:body]
         expect(current_path).to eq question_path(question)

      end

    end

  end

end