FactoryBot.define do
  factory :site do
    sequence(:url) { 'github.com' }
    sequence(:id) { |n| n }
  end
end
