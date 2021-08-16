require 'rails_helper'

RSpec.describe 'TagCategory', type: :model do

  context 'タグカテゴリー名が入力された場合' do
    it "バリデーションが通る" do
      tag_category = FactoryBot.build(:tag_category)
      expect(tag_category).to be_valid
    end
  end
  context 'タグカテゴリー名が空の場合' do
    it "バリデーションにひっかかる" do
      tag_category = FactoryBot.build(:tag_category, name: nil)
      expect(tag_category).not_to be_valid
    end
  end
  context 'タグカテゴリー名が重複している場合' do
    it "バリデーションにひっかかる" do
      tag_category1 = FactoryBot.create(:tag_category)
      tag_category2 = FactoryBot.build(:tag_category)
      expect(tag_category2).not_to be_valid
    end
  end
  context 'タグカテゴリー名が51文字以上の場合' do
    it "バリデーションにひっかかる" do
      tag_category = FactoryBot.build(:tag_category, name: 'A'*51)
      expect(tag_category).not_to be_valid
    end
  end
end
