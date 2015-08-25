require_relative '../acceptance_helper'

feature 'User adds a comment to the question' do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }

  describe 'Authenticated user' do

    background do
      sign_in user
      visit question_path(question)
    end

    scenario 'adds a comment to the answer', js: true do

      within ".answers" do

        fill_in 'Comment', with: attributes_for(:comment)[:body]
        click_on 'Add a comment'

        expect(page).to have_content attributes_for(:comment)[:body]
        expect(current_path).to eq question_path(question)

      end

    end

    scenario 'does not add a comment to the answer with invalid attributes', js: true do

      within ".answers" do

        fill_in 'Comment', with: attributes_for(:invalid_comment)[:body]
        click_on 'Add a comment'

        expect(page).to have_content "Body is too short (minimum is 5 characters)"
        expect(page).to have_content "Body can't be blank"

      end

    end

  end

  describe 'Not authenticated user' do

    background { visit question_path(question) }

    scenario 'has not such rights to add a comment', js: true do

      within ".answers" do

        expect(page).to_not have_button 'Add a comment'
        expect(page).to_not have_selector 'textarea'

      end

    end

  end

end