FactoryGirl.define do
  factory :user do
    email     { FFaker::Internet.email }
    password  { FFaker::Internet.password }
    role      'customer'

    factory :admin do
      role 'admin'
    end

    factory :customer do
      role 'customer'
    end

    factory :agent do
      role 'agent'
    end
  end
end
