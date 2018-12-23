FactoryBot.define do
  factory :point do
    association :track, strategy: :build
    tracked_at { Time.current }
    lat { 1 }
    lng { 1 }
    altitude { 1 }
  end
end
