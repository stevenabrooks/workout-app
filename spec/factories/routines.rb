FactoryGirl.define do
  factory :routine do
    name 'test workout for rspec'
    date "2013-08-01" 
    user_id 1
    bodyweight 195
  end
end