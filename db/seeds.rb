# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#user
user = User.create!(
  name: "松村龍之介",
  email: "matsumura@gmail.com",
  password: "asdf123",
  password_confirmation:"asdf123",
  profile: "こんにちは！管理者の松村龍之介です。",
  admin: true,
  public_or_private: true
)
(2..9).each do |n|
  User.create!(
    name: "松村龍之介#{n}",
    email: "matsumura#{n}@gmail.com",
    password: "asdf123",
    password_confirmation:"asdf123",
    profile: "こんにちは！一般ユーザーの松村龍之介#{n}です。",
    admin: false,
    public_or_private: true
  )
end


#post
require "csv"

CSV.foreach('db/post_seed.csv', headers: true) do |row|
  user.posts.create!(name: row['name'],
                    url: row['url'],
                    memo: row['memo'],
                    image:File.open(row['image'])
                    )
end


#category
category_array = ["肉料理", "魚料理", "和食", "デザート", "丼もの", "麺類", "サラダ", "汁もの"]
category_array.each do |array|
  Category.create!(
    name: array
  )
end


#post_category
CSV.foreach('db/post_category_seed.csv', headers: true) do |row|
  PostCategory.create!(post_id: row['post_id'],
                      category_id: row['category_id']
                      )
end


#tag_category
tag_category_array = ["肉類", "魚類", "野菜・果物類", "麺類", "大豆・豆腐類", "きのこ類", "調味料", "乳製品"]
tag_category_array.each do |tag_category|
  TagCategory.create!(
    name: tag_category
  )
end


#tag
tag_array = [
  ["鶏肉", "豚肉", "牛肉"],
  ["鮭", "あじ", "さば"],
  ["にんじん", "じゃがいも", "トマト"],
  ["パスタ", "うどん", "そば"],
  ["豆腐", "油揚げ", "納豆"],
  ["しいたけ", "しめじ", "エリンギ"],
  ["しょうゆ", "みりん", "コンソメ"],
  ["牛乳", "チーズ", "バター"]
]

tag_array.each_with_index do |array, i|
  array.each do |tag|
    TagCategory.find(i + 1).tags.create!(
      name: tag
    )
  end
end


#post_tag
CSV.foreach('db/post_tag_seed.csv', headers: true) do |row|
  PostTag.create!(
    post_id: row['post_id'],
    tag_id: row['tag_id']
  )
end



#level_setting
array = []
i = 0
10.times { array << i += 5 }

i = 0
array.each_with_index do |value, n|
  LevelSetting.create!(level: n + 1, thresold: i += value)
end
