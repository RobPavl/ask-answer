require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'invalid without a title' do
  	question = Question.new(title: nil)
  	question.valid?
  	expect(question.errors[:title]).to include("can't be blank")
  end

end
