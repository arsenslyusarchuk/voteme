FactoryGirl.define do
  factory :identity do
    provider 'google_oauth2'
    uid Faker::Number.number(21)
    user
  end
end
