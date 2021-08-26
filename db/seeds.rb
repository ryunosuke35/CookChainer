# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "csv"

#user
user = User.create!(
  name: "管理者",
  email: "matsumura@gmail.com",
  password: "asdf123",
  password_confirmation:"asdf123",
  profile: "こんにちは！これは管理者のアカウントです。",
  admin: true,
  public_or_private: true
)
# (2..9).each do |n|
#   User.create!(
#     name: "松村龍之介#{n}",
#     email: "matsumura#{n}@gmail.com",
#     password: "asdf123",
#     password_confirmation:"asdf123",
#     profile: "こんにちは！一般ユーザーの松村龍之介#{n}です。",
#     admin: false,
#     public_or_private: true
#   )
# end


# #post
CSV.foreach('db/csv/post.csv', headers: true) do |row|
  user.posts.create!(name: row['name'],
    url: row['url'],
    memo: row['memo'],
    image:File.open(row['image'])
  )
end


#category
category_array = ["主菜", "副菜", "汁もの", "主食", "デザート", "その他"]
category_array.each do |array|
  Category.create!(
    name: array
  )
end


#post_category
CSV.foreach('db/csv/post_category.csv', headers: true) do |row|
  PostCategory.create!(post_id: row['post_id'],
    category_id: row['category_id']
  )
end


#tag_category
tag_category_array = ["肉類", "魚介類", "野菜", "野菜（根菜）", "フルーツ", "きのこ類", "ハム・ソーセージ・加工品", "米・パン・麺・もち", "卵・乳製品", "豆腐・大豆加工品", "漬物・練物・こんにゃく", "乾物・海藻", "粉類・製菓材料", "缶詰・レトルト", "菓子・ナッツ", "飲料・酒・茶", "調味料・油"]
tag_category_array.each do |tag_category|
  TagCategory.create!(
    name: tag_category
  )
end


# #tag
CSV.foreach('db/csv/tag.csv', headers: true) do |row|
  Tag.create!(
    name: row['name'],
    tag_category_id: row['tag_category_id']
  )
end


#post_tag
CSV.foreach('db/csv/post_tag.csv', headers: true) do |row|
  PostTag.create!(
    post_id: row['post_id'],
    tag_id: row['tag_id']
  )
end


#level_setting
CSV.foreach('db/csv/level_setting.csv', headers: true) do |row|
  LevelSetting.create!(
    level: row['level'],
    thresold: row['thresold']
  )
end
