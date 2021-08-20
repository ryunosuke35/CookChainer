require 'rails_helper'

RSpec.describe 'Tag', type: :model do



  context 'タグ名が入力された場合' do
    it "バリデーションが通る" do
      tag_category = FactoryBot.create(:tag_category)
      tag = FactoryBot.build(:tag, tag_category:tag_category)
      expect(tag).to be_valid
    end
  end
  context 'タグ名が空の場合' do
    it "バリデーションにひっかかる" do
      tag = FactoryBot.build(:tag, name: nil)
      expect(tag).not_to be_valid
    end
  end
  context 'タグ名が重複している場合' do
    it "バリデーションにひっかかる" do
      tag_category = FactoryBot.create(:tag_category)
      tag1 = FactoryBot.create(:tag, tag_category:tag_category)
      tag2 = FactoryBot.build(:tag, tag_category:tag_category)
      expect(tag2).not_to be_valid
    end
  end
  context 'タグ名が51文字以上の場合' do
    it "バリデーションにひっかかる" do
      tag = FactoryBot.build(:tag, name: 'A'*51)
      expect(tag).not_to be_valid
    end
  end
end
