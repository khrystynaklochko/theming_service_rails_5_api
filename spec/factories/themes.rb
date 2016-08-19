FactoryGirl.define do
  factory :theme do
    sequence(:name) { |n| "name #{n}" }
    sequence(:style) { |n| "name #{n}" }
  end
end
