FactoryGirl.define do
  
  sequence :email do |n|
    "user#{n}@demostackoverflow.com"
  end

  sequence :password do |n|
    "user-pass#{n}"
  end

  sequence :password_confirmation  do |n|
    "user-pass#{n}"
  end

  factory :user do
    email
    password 
    password_confirmation 
  end

end
