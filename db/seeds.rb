# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(
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


category_array = ["肉料理", "魚料理", "和食", "デザート", "丼もの", "麺類", "サラダ", "汁もの"]
category_array.each do |array|
  Category.create!(
    name: array
  )
end





array = []
i = 0
10.times { array << i += 5 }

i = 0
array.each_with_index do |value, n|
  LevelSetting.create!(level: n + 1, thresold: i += value)
end
