require 'rails_helper'

feature 'User can look page with specified question and answers to it' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 2, question: question, user: user) }

  scenario 'User goes to specified question and looks what is inside' do

    sign_in user

    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    answers.map do |a|
      expect(page).to have_content a.body
    end

    expect(current_path).to eq question_path(question)

  end

end