# frozen_string_literal: true

FactoryBot.define do
  trait :active do
    active { true }
  end

  trait :disabled do
    active { false }
  end

  trait :out_of_stock do
    quantity { 0 }
  end

  factory :product do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    price { rand 1..1000 }
    old_price { rand 1..1000 }
    status { 0 }
    quantity { rand 1..100 }
    poster do
      Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/test.jpg'), 'image/jpeg')
    end
  end
end
