require 'rails_helper'

feature 'User creates a question' do

  given(:user) { create(:user) }
  given(:question) { build(:question) }

  scenario 'Authenticated user creates a question' do

    sign_in user
    visit root_path
    click_on 'Ask a question'

    fill_in 'Title', with: question.title
    fill_in 'Text', with: question.body
    click_on 'Save a question'

    expect(page).to have_content 'Question successfully created'
    expect(page).to have_content question.title
    expect(page).to have_content question.body

  end

  scenario 'Non authenticated user has no such rights to ask a question' do

    visit root_path
    click_on 'Ask a question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path

  end

end