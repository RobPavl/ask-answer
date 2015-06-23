require 'rails_helper'

feature 'User creates an answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user ) }
  given(:answers) { [attributes_for(:answer)[:body],attributes_for(:answer)[:body]] }

  scenario 'Authenticated user answers for the question' do

    sign_in user
    visit question_path(question)

    answers.map do |a|

      fill_in 'Text', with: a
      click_on 'Give an answer'
      sleep(1)

      expect(page).to have_content a

    end

    expect(page).to have_content 'Answer successfully added!'

    expect(current_path).to eq question_path(question)

  end

  scenario 'Unauthenticated user can not give an answer for the question' do

    visit question_path(question)
    expect(page).to_not have_button 'Give an answer'

  end

end