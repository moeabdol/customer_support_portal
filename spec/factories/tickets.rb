FactoryGirl.define do
  factory :ticket do
    content { FFaker::Lorem.paragraphs.join(' ') }
    status 'unresolved'
  end
end
