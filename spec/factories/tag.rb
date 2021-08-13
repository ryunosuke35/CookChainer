FactoryBot.define do
  factory :tag do
    name { 'デフォルトのタグ1' }
    association :tag_category
  end
  factory :second_tag, class: Tag do
    name { 'デフォルトのタグ2' }
  end
end
