require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe 'バリデーションのテスト' do
    context '名前、メールアドレス、パスワード、確認用パスワードが入力された場合' do
      it "バリデーションが通る" do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end
    context '名前が空の場合' do
      it "バリデーションにひっかかる" do
        user = FactoryBot.build(:user, name: nil)
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスが空の場合' do
      it "バリデーションにひっかかる" do
        user = FactoryBot.build(:user, email: nil)
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスが重複している場合' do
      it "バリデーションにひっかかる" do
        user1 = FactoryBot.create(:user)
        user2 = FactoryBot.build(:user)
        expect(user2).not_to be_valid
      end
    end
    context 'メールアドレスが不正な値の場合' do
      it "バリデーションにひっかかる" do
        user = FactoryBot.build(:user, email: 'aaaaaaaaaaaaaaaaa' )
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスを正規表現と比較した場合' do
      it "マッチする" do
        user = FactoryBot.build(:user)
        expect(user[:email]).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
      end
    end
    context 'パスワードが空の場合' do
      it "バリデーションにひっかかる" do
        user = FactoryBot.build(:user, password: nil)
        expect(user).not_to be_valid
      end
    end
    context 'パスワードが6文字未満の場合' do
      it "バリデーションにひっかかる" do
        user = FactoryBot.build(:user, password: 'passw' )
        expect(user).not_to be_valid
      end
    end
    context 'パスワードと確認用パスワードの内容が異なる場合' do
      it "バリデーションにひっかかる" do
        user = FactoryBot.build(:user, password: 'password', password_confirmation: 'passwords' )
        expect(user).not_to be_valid
      end
    end
  end
end
