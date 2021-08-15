require 'rails_helper'

RSpec.describe 'User', type: :system do

  describe 'アカウント登録のテスト' do
    context 'アカウント登録をした場合' do
      it 'マイページが表示される' do
        visit new_user_registration_path
        fill_in 'user_name', with: '田中太郎'
        fill_in 'user_email', with: 'tanaka@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on '登録する'
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(page).to have_content '田中太郎'
        expect(page).to have_content 'matsumura@gmail.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end
end
