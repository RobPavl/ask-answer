FactoryGirl.define do
   factory :vote do
     user
     score 1
   end
   
  factory :dislike_vote, class: Vote do
    user
    score -1
  end

end
 