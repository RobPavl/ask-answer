require_relative '../acceptance_helper'

feature 'User gives a score to a question' do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }


  describe 'Authenticated user' do

    background do
      sign_in user
      visit question_path(question)
    end

    scenario 'gives a score to a question', js: true do

      click_on 'Like'

      expect(page).to_not have_link 'Like'
      expect(page).to have_link 'Cancel vote'

    end
    scenario 'cancels given score', js: true

  end
end

