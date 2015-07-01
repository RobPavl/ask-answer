require 'rails_helper'

feature 'User deletes an answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given(:non_author) { create(:user) }

  scenario 'User deletes his own answer, but not others' do

    sign_in user
    visit question_path(question)

    expect(page).to have_content answer.body

    click_on 'Delete'

    expect(page).to_not have_content answer.body
    expect(page).to_not have_link 'Delete'

  end

  scenario 'Nonauthenticated user has no such rights to delete answer' do

    visit question_path(question)
    expect(page).to_not have_link 'Delete'

  end

  scenario 'Non-author of the answer tries to delete answer' do
    sign_in(non_author)
 
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
    
  end

end
