require 'rails_helper'

RSpec.describe 'User', type: :system do

  # describe 'アカウント登録機能のテスト' do
  #   context 'アカウント登録をした場合' do
  #     it 'マイページが表示される' do
  #       visit new_user_registration_path
  #       fill_in 'user_name', with: '田中太郎'
  #       fill_in 'user_email', with: 'tanaka@gmail.com'
  #       fill_in 'user_password', with: 'password'
  #       fill_in 'user_password_confirmation', with: 'password'
  #       click_on 'アカウント登録'
  #       expect(page).to have_content 'アカウント登録が完了しました。'
  #       expect(page).to have_content '田中太郎'
  #       expect(page).to have_content 'tanaka@gmail.com'
  #     end
  #   end
  # end

  describe 'ログイン機能のテスト' do
    context 'ログインをした場合' do
      it 'マイページが表示される' do
        visit new_user_session_path
        fill_in 'user_name', with: '田中太郎'
        fill_in 'user_email', with: 'tanaka@gmail.com'
        fill_in 'user_password', with: 'password'
        click_on 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content '田中太郎'
        expect(page).to have_content 'tanaka@gmail.com'
      end
    end
    context 'ログアウトをした場合' do
      it 'ログイン画面に遷移する' do
        visit new_user_session_path
        fill_in 'user_name', with: '田中太郎'
        fill_in 'user_email', with: 'tanaka@gmail.com'
        fill_in 'user_password', with: 'password'
        click_on 'ログイン'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content '田中太郎'
        expect(page).to have_content 'tanaka@gmail.com'
      end
    end
  end
end
