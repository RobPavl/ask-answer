require 'rails_helper'

feature 'User creates an answer' do

  given!(:user) { create(:user) }
  given(:question) { create(:question, user: user ) }
  given(:answers) { [attributes_for(:answer)[:body],attributes_for(:answer)[:body]] }

  scenario 'Authenticated user answers for the question', js: true do

    sign_in(user)
    sleep(2)
    visit question_path(question)

    answers.each do |a|

      save_page
      fill_in 'Text', with: a
      click_on 'Give an answer'

      within '.answers' do
        expect(page).to have_content a
      end
    
    expect(page).to have_content 'Answer successfully added!'
    
    end

    expect(current_path).to eq question_path(question)

  end

  scenario 'Unauthenticated user can not give an answer for the question' do

    visit question_path(question)
    expect(page).to_not have_button 'Give an answer'

  end

end