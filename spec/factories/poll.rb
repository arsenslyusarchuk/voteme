FactoryGirl.define do
  factory :poll do
    title     'A short poll title'
    description  'a' * 128
    poll_type    {['checkbox', 'radio'].sample}
    user

    after(:create) do |poll, evaluator|
      [*1..5].sample.times do
        FactoryGirl.create(:answer, poll: poll)
      end
    end
  end
end
