require 'rails_helper'

RSpec.describe 'Category', type: :model do

  context 'カテゴリー名が入力された場合' do
    it "バリデーションが通る" do
      category = FactoryBot.build(:category)
      expect(category).to be_valid
    end
  end
  context 'カテゴリー名が空の場合' do
    it "バリデーションにひっかかる" do
      category = FactoryBot.build(:category, name: nil)
      expect(category).not_to be_valid
    end
  end
  context 'カテゴリー名が重複している場合' do
    it "バリデーションにひっかかる" do
      category1 = FactoryBot.create(:category)
      category2 = FactoryBot.build(:category)
      expect(category2).not_to be_valid
    end
  end
  context 'カテゴリー名が51文字以上の場合' do
    it "バリデーションにひっかかる" do
      category = FactoryBot.build(:category, name: 'A'*51)
      expect(category).not_to be_valid
    end
  end
end
