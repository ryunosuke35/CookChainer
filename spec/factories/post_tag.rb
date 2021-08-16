FactoryBot.define do
  factory :post_tag do
    post_id { 1 }
    tag_id { 1 }
  end
  factory :second_post_tag, class: PostTag do
    post_id { 2 }
    tag_id { 2 }
  end
end
