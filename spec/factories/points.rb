# frozen_string_literal: true

FactoryBot.define do
  factory :point do
    association :track, strategy: :build
    tracked_at { Time.current }
    lat { 1 }
    lng { 1 }
    sequence(:displacement_sequence, &:to_s)
    altitude { 1 }
    uniq_by_displacement { true }
  end
end
