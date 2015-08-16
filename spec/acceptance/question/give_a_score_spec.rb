require_relative '../acceptance_helper'

feature 'User gives a score to a question' do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }


  describe 'Authenticated user' do

    context 'Not author' do

      background do
        sign_in user
        visit question_path(question)
      end

      scenario 'gives a score to a question', js: true do

        click_on 'Like'

        sleep(1)

        expect(page).to_not have_link 'Like'
        expect(page).to have_link 'Cancel vote'
        expect(page).to have_content 'Votes:1'
 
        click_on 'Cancel vote'

        sleep(1)
 
        expect(page).to have_link 'Like'
        expect(page).to have_link 'Dislike'
        expect(page).to_not have_link 'Cancel vote'
        expect(page).to have_content 'Votes:0'
 
        click_on 'Dislike'
 
        sleep(1)

        expect(page).to_not have_link 'Like'
        expect(page).to_not have_link 'Dislike'
        expect(page).to have_link 'Cancel vote'
        expect(page).to have_content 'Votes:-1'

      end

      end

    context 'Author' do

      background do
        sign_in user
        visit question_path(question)
      end

      scenario 'has not ability to give a score to a question', js: true do

        expect(page).to_not have_link 'Like'
        expect(page).to_not have_link 'Dislike'
        expect(page).to_not have_link 'Cancel vote'

      end

    end
 
  end
 
    scenario 'Not authenticated user has not such rights to add a file', js: true do

      visit question_path(question)

      expect(page).to_not have_link 'Like'
      expect(page).to_not have_link 'Dislike'
      expect(page).to_not have_link 'Cancel vote'

    end

end

