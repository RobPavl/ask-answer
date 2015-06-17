require 'rails_helper'

feature 'User sign in', %q{
	I'm a User
	If I want to ask some question
	I must to sign in
} do
	
  scenario 'Registered user tries to enter' do
  	User.create!(email: 'username@test.com', password: 'qwertyuiop')

  	visit new_user_session_path
  	fill_in 'Email', with: 'username@test.com'
  	fill_in 'Password', with: 'qwertyuiop'
    click_on 'Log in'

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