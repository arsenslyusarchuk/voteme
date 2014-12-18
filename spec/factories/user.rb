FactoryGirl.define do
  factory :user do
    email      Faker::Internet.email
    password   'testingg'
    password_confirmation 'testingg'

    after(:create) do |user|
      FactoryGirl.create(:identity, user: user)
    end
  end
end
