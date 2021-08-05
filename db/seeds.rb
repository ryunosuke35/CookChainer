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


LevelSetting.create!(level: 2, thresold: 10)
LevelSetting.create!(level: 3, thresold: 30)
LevelSetting.create!(level: 4, thresold: 60)
LevelSetting.create!(level: 5, thresold: 100)
LevelSetting.create!(level: 6, thresold: 150)
LevelSetting.create!(level: 7, thresold: 210)
LevelSetting.create!(level: 8, thresold: 280)
LevelSetting.create!(level: 9, thresold: 360)
LevelSetting.create!(level: 10, thresold: 450)
