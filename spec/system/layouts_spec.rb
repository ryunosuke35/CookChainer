require 'rails_helper'

RSpec.describe 'Category', type: :system do

  let!(:general_user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:second_user) }
  let!(:level1) { FactoryBot.create(:level_setting) }
  let!(:level2) { FactoryBot.create(:second_level_setting) }

  def general_login
    visit new_user_session_path
    fill_in 'user_name', with: '一般ユーザー'
    fill_in 'user_email', with: 'general_user@gmail.com'
    fill_in 'user_password', with: 'password'
    within '.actions' do
      click_on 'ログイン'
    end
  end

  def admin_login
    visit new_user_session_path
    fill_in 'user_name', with: '管理者'
    fill_in 'user_email', with: 'admin@gmail.com'
    fill_in 'user_password', with: 'password'
    within '.actions' do
      click_on 'ログイン'
    end
  end



  describe 'グローバルナビゲーションのテスト' do
    context 'マイページをクリックした場合' do
      it 'マイページに遷移する' do
        admin_login
        visit user_path(admin_user.id)
        click_link 'マイページ'
        expect(current_path).to eq user_path(admin_user.id)
      end
    end
    context '投稿をクリックした場合' do
      it '新規投稿画面に遷移する' do
        admin_login
        visit user_path(admin_user.id)
        click_link '投稿'
        expect(current_path).to eq new_post_path
      end
    end
    context '記録をクリックした場合' do
      it '記録画面に遷移する' do
        admin_login
        visit user_path(admin_user.id)
        click_link '記録'
        expect(current_path).to eq posts_path
      end
    end
    context '一覧をクリックした場合' do
      it '一覧画面に遷移する' do
        admin_login
        visit user_path(admin_user.id)
        click_link '一覧'
        expect(current_path).to eq index2_posts_path
      end
    end
    context 'カテゴリをクリックした場合' do
      it 'カテゴリー一覧画面に遷移する' do
        admin_login
        visit user_path(admin_user.id)
        click_link 'カテゴリ'
        expect(current_path).to eq categories_path
      end
    end
    context 'タグをクリックした場合' do
      it 'タグ一覧画面に遷移する' do
        admin_login
        visit user_path(admin_user.id)
        click_link 'タグ'
        expect(current_path).to eq tags_path
      end
    end
    context 'タグカテゴリをクリックした場合' do
      it 'タグカテゴリー一覧画面に遷移する' do
        admin_login
        visit user_path(admin_user.id)
        click_link 'タグカテゴリ'
        expect(current_path).to eq tag_categories_path
      end
    end
  end
end
