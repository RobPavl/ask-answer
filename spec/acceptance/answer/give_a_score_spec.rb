require_relative '../acceptance_helper'

feature 'User gives a score to an answer' do

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question)}
  given!(:answer_1) { create(:answer, question: question, user:author) }
  given!(:answer_2) { create(:answer, question: question, user:author) }

  describe 'Authenticated user' do

      context 'Not author'do

        background do
          sign_in user
          visit question_path(question)
        end

        scenario 'gives a score to an answer', js: true do

        within '.answers' do

          within "#answer-#{answer_1.id}" do

            click_on 'Like'
           
            expect(page).to_not have_link 'Like'
            expect(page).to have_link 'Cancel vote'
            expect(page).to have_content 'Votes:1'

          end

          within "#answer-#{answer_2.id}" do

            click_on 'Dislike'

            expect(page).to_not have_link 'Like'
            expect(page).to have_link 'Cancel vote'
            expect(page).to have_content 'Votes:-1'

          end

          within "#answer-#{answer_1.id}" do

            click_on 'Cancel vote'

            expect(page).to have_link 'Like'
            expect(page).to have_link 'Dislike'
            expect(page).to_not have_link 'Cancel vote'
            expect(page).to have_content 'Votes:0'

          end

          within "#answer-#{answer_2.id}" do

            click_on 'Cancel vote'

            expect(page).to have_link 'Like'
            expect(page).to have_link 'Dislike'
            expect(page).to_not have_link 'Cancel vote'
            expect(page).to have_content 'Votes:0'

          end

        end

      end

    end

    context 'Author' do

      background do
        sign_in author
        visit question_path(question)
      end

      scenario 'has not ability to vote for an answer' do

        within '.answers' do

            within "#answer-#{answer_1.id}" do

              expect(page).to_not have_link 'Dislike'
              expect(page).to_not have_link 'Like'
              expect(page).to_not have_link 'Cancel vote'

            end

          end
          
      end

    end

  end

end