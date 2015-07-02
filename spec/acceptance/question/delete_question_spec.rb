require 'rails_helper'

feature 'User deletes a question' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:non_author) { create(:user) }
  
  scenario 'Authenticated author can delete his own question, but not others' do

    sign_in user
    visit root_path
    
    expect(page).to have_content question.title
    click_on 'Delete'

    expect(page).to_not have_content question.title
    expect(page).to_not have_link 'Delete'

  end

  scenario 'Non-authenticated user has no such rights to delete a question' do

    visit root_path
    expect(page).to_not have_link 'Delete'

  end

  scenario 'Non-author of the question tries to delete question' do
    sign_in(non_author)
 
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
    
  end

end