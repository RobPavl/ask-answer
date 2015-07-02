require 'rails_helper'

feature 'User sign in', %q{
	I'm a User
	If I want to ask some question
	I must to sign in
} do
	
  given(:user) { create(:user) }

  scenario 'Registered user tries to enter' do

    sign_in user

  	expect(page).to have_content 'Signed in successfully.'
  	expect(current_path).to eq root_path
  end

  scenario 'Unregistered user tries to enter' do
    visit new_user_session_path
  	fill_in 'Email', with: 'wrong@test.com'
  	fill_in 'Password', with: 'qwertyuiop'
  	click_on 'Log in'

  	expect(page).to have_content 'Invalid email or password.'
  	expect(current_path).to eq new_user_session_path
  end

end