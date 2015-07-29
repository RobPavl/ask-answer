require_relative '../acceptance_helper'

feature 'User adds a file when creating an answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:files) { ['/spec/rails_helper.rb','/spec/spec_helper.rb']}

  background do
    sign_in user
    visit question_path(question)
  end

  describe 'Authenticated user' do

    scenario 'adds files to an answer', js: true do

      fill_in 'Text', with: attributes_for(:answer)[:body]
      
      2.times do |n|

        click_on 'Add file'
        inputs = all('input[type="file"]')
        inputs[n].set("#{Rails.root}#{files[n]}")

      end

      click_on 'Give an answer'

      within '.answers' do
        expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/2/spec_helper.rb'      
      end

    end

  end

end 
