FactoryBot.define do
  factory :post_category do
    post_id { 1 }
    category_id { 1 }
  end
  factory :second_post_category, class: PostCategory do
    post_id { 2 }
    category_id { 2 }
  end
end
