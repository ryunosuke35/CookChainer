require 'rails_helper'

RSpec.describe 'Post', type: :model do

  context '料理名、url、メモが入力された場合' do
    it "バリデーションが通る" do
      post = FactoryBot.build(:post)
      expect(post).to be_valid
    end
  end
  context '料理名が空の場合' do
    it "バリデーションにひっかかる" do
      post = FactoryBot.build(:post, name: nil)
      expect(post).not_to be_valid
    end
  end
  context '料理名が101文字以上の場合' do
    it "バリデーションにひっかかる" do
      post = FactoryBot.build(:post, name: 'A'*101)
      expect(post).not_to be_valid
    end
  end
  context 'urlが不正な値の場合' do
    it "バリデーションにひっかかる" do
      post = FactoryBot.build(:post, url: 'aaaaaaaaaaaaaaaaa' )
      expect(post).not_to be_valid
    end
  end
  context 'urlを正規表現と比較した場合' do
    it "マッチする" do
      post = FactoryBot.build(:post)
      expect(post[:url]).to match(/\A#{URI::regexp(%w(http https))}\z/)
    end
  end
end
