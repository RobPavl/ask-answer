require 'rails_helper'

feature 'User see the list of questions' do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2, user: user)}

  scenario 'Authenticated user view index page' do

    sign_in user

    questions.each { |q| expect(page).to have_content q.title }

  end

  scenario 'Non authenticated user also sees all the questions' do

    visit root_path

    questions.each { |q| expect(page).to have_content q.title }

  end

end