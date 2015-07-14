require_relative '../acceptance_helper'

feature 'User deletes an answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given(:non_author) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:other_user_answer) { create(:answer, question: question, user: other_user) }

  scenario 'User deletes his own answer, but not others', js: true do

    sign_in user
    visit question_path(question)
# save_and_open_page
    expect(page).to have_content answer.body

    within "#answer-#{answer.id}" do
      click_on 'Delete'
    end

    expect(page).to_not have_content answer.body
   
    within "#answer-#{other_user_answer.id}" do
      expect(page).to_not have_link 'Delete'
    end

  end

  scenario 'Nonauthenticated user has no such rights to delete answer', js: true  do

    visit question_path(question)
    expect(page).to_not have_link 'Delete'

  end

  scenario 'Non-author of the answer tries to delete answer', js: true do
    sign_in(non_author)
 
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
    
  end

end
