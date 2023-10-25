FactoryBot.define do
  factory :user do
    id { 10 }
    name { "John" }
    email { "john@example.com" }
    password { "Password1!" }
    password_confirmation { "Password1!" }
    confirmed_at { Date.today }
  end
end
