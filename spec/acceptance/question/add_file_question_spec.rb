require_relative '../acceptance_helper'

feature 'User adds a file while creating a question' do
  
  given(:user) { create(:user) }
  given(:files) { ['/spec/rails_helper.rb','/spec/spec_helper.rb']}

  describe 'Authenticated user' do

  	background do
      sign_in user
      visit new_question_path
    end

    scenario 'adds more than one file while creating a question', js: true do

      fill_in 'Title', with: attributes_for(:question)[:title]
      fill_in 'Text', with: attributes_for(:question)[:body]
      
      2.times do |n|
        click_on 'Add file'
        inputs = all('input[type="file"]')
        inputs[n].set("#{Rails.root}#{files[n]}")

      end

      click_on 'Save a question'

      within('.question') do

        expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/2/spec_helper.rb'
      end

    end

  end

	scenario 'Not authenticated user has not such rights to add a file', js: true do

	  visit new_question_path
	  expect(page).to_not have_link 'Add file'

	end

end	