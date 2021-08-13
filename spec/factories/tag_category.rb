FactoryBot.define do
  factory :tag_category do
    name { 'デフォルトのタグカテゴリー1' }
  end
  factory :second_tag_category, class: TagCategory do
    name { 'デフォルトのタグカテゴリー2' }
  end
end
