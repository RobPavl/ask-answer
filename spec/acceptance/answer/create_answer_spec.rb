require_relative '../acceptance_helper'

feature 'User creates an answer' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:answers) { [attributes_for(:answer)[:body],attributes_for(:answer)[:body]] }

  describe 'Authenticated user' do

    before do
      sign_in(user)
      visit question_path(question)
    end


    scenario 'gives an answer for the question', js: true do

      answers.each do |a|
        fill_in 'Text', with: a
        click_on 'Give an answer'

        within '.answers' do
          expect(page).to have_content a
        end

        expect(page).to have_content 'Answer successfully added!'
      end

        expect(current_path).to eq question_path(question)

    end

    scenario 'trying to create answer with empty body', js: true do

      click_on 'Give an answer'

      within '.new_answer_errors' do
        expect(page).to have_content "Body can't be blank"
      end

      expect(current_path).to eq question_path(question)

    end
    
  end

  scenario 'Unauthenticated user can not give an answer for the question' do

    visit question_path(question)
    expect(page).to_not have_button 'Give an answer'

  end

end