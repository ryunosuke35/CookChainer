require 'rails_helper'

RSpec.describe 'Category', type: :system do

  let!(:general_user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:second_user) }
  let!(:category1) { FactoryBot.create(:category) }
  let!(:category2) { FactoryBot.create(:second_category) }

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


  describe 'ログインせずに画面遷移した際のテスト' do
    context 'ログインせずにカテゴリー一覧画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit categories_path
        expect(current_path).to eq new_user_session_path
      end
    end
    context 'ログインせずにカテゴリー作成画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit new_category_path
        expect(current_path).to eq new_user_session_path
      end
    end
    context 'ログインせずにカテゴリー編集画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit edit_category_path(category1.id)
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe '一覧機能のテスト' do
    context '一覧画面に遷移した場合' do
      it '登録済みのカテゴリーが表示される' do
        FactoryBot.create(:category, name: '主菜')
        admin_login
        visit categories_path
        expect(page).to have_content '主菜'
      end
    end
    context '編集ボタンをクリックした場合' do
      it '編集画面に遷移する' do
        category = FactoryBot.create(:category, name: '主菜')
        admin_login
        visit categories_path
        all('tbody tr')[2].click_on '編集'
        expect(current_path).to eq edit_category_path(category.id)
        expect(page).to have_content 'カテゴリー編集'
      end
    end
    context '削除ボタンをクリックした場合' do
      it 'カテゴリーが削除され、一覧画面に遷移する' do
        FactoryBot.create(:category, name: '主菜')
        admin_login
        visit categories_path
        all('tbody tr')[2].click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '「主菜」を削除しました'
        visit current_path
        expect(current_path).to eq categories_path
        expect(page).not_to have_content '主菜'
      end
    end
    context 'カテゴリーを作成するをクリックした場合' do
      it '新規作成画面に遷移する' do
        FactoryBot.create(:category, name: '主菜')
        admin_login
        visit categories_path
        click_link 'カテゴリーを作成する'
        expect(current_path).to eq new_category_path
        expect(page).to have_content 'カテゴリー新規作成'
      end
    end
  end

  describe '新規作成機能のテスト' do
    context 'カテゴリーを新規作成した場合' do
      it '登録したカテゴリーが表示される' do
        admin_login
        visit new_category_path
        fill_in 'category_name', with: '主菜'
        click_on '登録する'
        expect(current_path).to eq categories_path
        expect(page).to have_content '「主菜」を作成しました'
      end
    end
    context '新規作成画面で「戻る」をクリックした場合' do
      it '一覧画面に遷移する' do
        admin_login
        visit new_category_path
        click_on '戻る'
        expect(current_path).to eq categories_path
      end
    end
  end

  describe '編集機能のテスト' do
    context 'カテゴリーを編集した場合' do
      it '投稿内容が更新される' do
        category = FactoryBot.create(:category, name: '主菜')
        admin_login
        visit edit_category_path(category.id)
        fill_in 'category_name', with: '副菜'
        click_on '更新する'
        expect(current_path).to eq categories_path
        expect(page).to have_content 'カテゴリー名を修正しました'
        expect(page).to have_content '副菜'
        expect(page).not_to have_content '主菜'
      end
    end
    context '編集画面で「戻る」をクリックした場合' do
      it '一覧画面に遷移する' do
        admin_login
        category = FactoryBot.create(:category, name: '主菜')
        visit edit_category_path(category.id)
        click_on '戻る'
        expect(current_path).to eq categories_path
      end
    end
  end
end
