require 'rails_helper'

feature 'User log out' do

  given(:user) { create(:user) }

  scenario 'Authenticated user sign out' do

    sign_in user
    expect(current_path).to eq root_path
    log_out

  end
end