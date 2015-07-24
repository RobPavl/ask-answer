require_relative '../acceptance_helper'

feature 'User adds a file while creating a question' do
  
  given(:user) { create(:user) }

  background do
    sign_in user
    visit new_question_path
  end

  describe 'Authenticated user' do

    scenario 'adds a file while creating a question', js: true do

      fill_in 'Title', with: attributes_for(:question)[:title]
      fill_in 'Text', with: attributes_for(:question)[:body]
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Save a question'

      within('.question') do

        expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'

      end

    end

  end

end	