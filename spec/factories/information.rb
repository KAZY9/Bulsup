FactoryBot.define do
  factory :information do
    id { 10 }
    user_id { 10 }
    sex { '男性' }
    age { 25 }
    height { 171 }
    weight { 65 }
    activity_level { 2 }
    start_date { '2023-10-21' }
    end_date { '2023-10-31' }
    weight_to_gain { 1.0 }
  end
end
