FactoryBot.define do
  factory :tag do
    name { 'デフォルトのタグ1' }
  end
  factory :second_tag, class: Tag do
    name { 'デフォルトのタグ2' }
  end
end
