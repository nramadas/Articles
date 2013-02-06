FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Example #{n}" }
    sequence(:email) { |n| "eg#{n}@gmail.com" }
    password "mynameiseg"
    password_confirmation "mynameiseg"
  end

  factory :article do
    sequence(:title) { |n| "New title! #{n}"}
    sequence(:body) { |n| "Body! #{n}"}
    picture nil
    author_id 1
  end
end