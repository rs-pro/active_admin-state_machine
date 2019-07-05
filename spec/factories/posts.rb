FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body { "lorem ipsum 2" }
    status { Post::DRAFT }

    category

    trait :reviewed do
      status { Post::REVIEWED }
    end
  end
end
