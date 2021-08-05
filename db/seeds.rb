# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


LevelSetting.create(:level => 2, :thresold => 10)
LevelSetting.create(:level => 3, :thresold => 20)
LevelSetting.create(:level => 4, :thresold => 30)
LevelSetting.create(:level => 5, :thresold => 40)
