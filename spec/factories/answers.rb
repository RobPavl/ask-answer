FactoryGirl.define do
 
  sequence :body do |n|
    "It is a body for answer##{n}"
  end

  factory :answer do
    body 
    user
    question
    best false
  end
  
  factory :invalid_answer, class: 'Answer' do
    body nil
    question
  end

end