FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "#{n}Name" }
    sequence(:email) { |n| "mail#{n}@fake.com" }
    sequence(:password_digest) { |n| "#{n}password" }
    sequence(:token) { |n| "#{n}token" }
  end
end
