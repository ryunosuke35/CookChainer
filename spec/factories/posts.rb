FactoryBot.define do
  factory :post do
    name { 'デフォルトの料理名1' }
    url { 'https://cookpad.com/' }
    memo { 'デフォルトのメモ1' }
    association :user
  end
  factory :second_post, class: Post do
    name { 'デフォルトの料理名2' }
    url { 'https://cookpad.com/' }
    memo { 'デフォルトのメモ2' }
    association :second_user
  end
end
