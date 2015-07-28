require_relative '../acceptance_helper'

feature 'User adds a file when creating an answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in user
    visit question_path(question)
  end

  describe 'Authenticated user' do

    scenario 'adds files to an answer', js: true do

      fill_in 'Text', with: attributes_for(:answer)[:body]
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Give an answer'

      within '.answers' do
        expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
      end

    end

  end

end 
