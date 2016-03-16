FactoryGirl.define do
  factory :post do
    # association :user, factory: :user
    # category
    
    title   {Faker::Company.bs}
    content {Faker::Lorem.paragraph}
  end
end
