require 'rails_helper'

RSpec.describe 'Tag', type: :model do

  context 'タグ名が入力された場合' do
    it "バリデーションが通る" do
      tag = FactoryBot.build(:tag)
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
      tag1 = FactoryBot.create(:tag)
      tag2 = FactoryBot.build(:tag)
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
