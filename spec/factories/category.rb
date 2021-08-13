FactoryBot.define do
  factory :category do
    name { 'デフォルトのカテゴリー1' }
  end
  factory :second_category, class: Category do
    name { 'デフォルトのカテゴリー2' }
  end
end
