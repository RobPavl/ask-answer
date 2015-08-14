FactoryGirl.define do
   factory :vote do
     user
     score :like
   end
   
  factory :dislike_vote, class: Vote do
    user
    score :dislike
  end

end
 