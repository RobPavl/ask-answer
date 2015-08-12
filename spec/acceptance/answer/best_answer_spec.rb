require_relative '../acceptance_helper'

feature 'User marks an answer as best' do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, user: user, question: question ) }

  describe 'Author of the question' do

    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'marks answer as best for the first time', js: true do

      within '.answers' do

        within "#answer-#{answers[2].id}" do

          click_on 'Mark as best'

          expect(page).to_not have_link 'Mark as best'
          expect(page).to have_content 'Best'

        end

        expect(page).to have_selector('.answer:first-of-type', text: answers[2].body)

      end

    end

    scenario 'marks new answer as best when question already has another best answer', js: true do

      within '.answers' do

        within "#answer-#{answers[1].id}" do
          click_on 'Mark as best'
        end

        sleep(1)

        within "#answer-#{answers[2].id}" do
          click_on 'Mark as best'
        end

        sleep(1)

        expect(page).to have_content('Best', count: 1)
        expect(page).to have_link('Mark as best', count: 2)

        within "#answer-#{answers[2].id}" do
          expect(page).to have_content 'Best'
          expect(page).to_not have_link 'Mark as best'
        end
        
        within "#answer-#{answers[1].id}" do
          expect(page).to_not have_content 'Best'
          expect(page).to have_link 'Mark as best'
        end

      end

    end

end

    describe 'Not author' do

      before do
        sign_in other_user
        visit question_path(question)
      end

        scenario 'Not author of the question has no such rights to mark answer as best', js: true do

          within '.answers' do
            expect(page).to_not have_link 'Mark as best'
          end

        end

    end

end