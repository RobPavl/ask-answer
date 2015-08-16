require_relative '../acceptance_helper'

feature 'User gives a score to an answer' do

  given(:author) { create(:user) }
  given(:question) { create(:question)}
  given(:answer) { create(:answer, question: question, user:author) }

  describe 'Authenticated user' do

    scenario 'gives a score to an answer', js: true do

      within '.answers' do

        click_on 'Like'

        expect(page).to_not have_link 'Like'
        expect(page).to have_link 'Cancel vote'

        click_on 'Cancel vote'

        expect(page).to have_link 'Like'
        expect(page).to have_link 'Dislike'
        expect(page).to_not have_link 'Cancel vote'

        click_on 'Dislike'

        expect(page).to_not have_link 'Like'
        expect(page).to_not have_link 'Dislike'
        expect(page).to have_link 'Cancel vote'

      end

    end

  end

end