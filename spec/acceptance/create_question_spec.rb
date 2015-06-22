require 'rails_helper'

feature 'User creates a question' do

  given(:user) { create(:user) }
  given(:question) { [attributes_for(:question)[:title], attributes_for(:question)[:body]] }

  scenario 'Authenticated user creates a question' do

    sign_in user

    click_on 'Ask a question'

    fill_in 'Title', with: question[0]
    fill_in 'Text', with: question[1]
    click_on 'Save a question'

    expect(page).to have_content 'Question successfully created'
    expect(page).to have_content question[0]
    expect(page).to have_content question[1]

  end

  scenario 'Non authenticated user has no such rights to ask a question' do

    visit root_path
    click_on 'Ask a question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path

  end

end