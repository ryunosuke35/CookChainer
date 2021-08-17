require 'rails_helper'

RSpec.describe 'Tag', type: :system do

  let!(:general_user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:second_user) }
  let!(:tag1) { FactoryBot.create(:tag, tag_category: tag_category1) }
  let!(:tag2) { FactoryBot.create(:second_tag, tag_category: tag_category1) }
  let!(:tag_category1) { FactoryBot.create(:tag_category) }
  let!(:tag_category2) { FactoryBot.create(:second_tag_category) }

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
    context 'ログインせずにタグ一覧画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tags_path
        expect(current_path).to eq new_user_session_path
      end
    end
    context 'ログインせずにタグ作成画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit new_tag_path
        expect(current_path).to eq new_user_session_path
      end
    end
    context 'ログインせずにタグ編集画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit edit_tag_path(tag1.id)
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe '一覧機能のテスト' do
    context '一覧画面に遷移した場合' do
      it '登録済みのカテゴリーが表示される' do
        tag_category = FactoryBot.create(:tag_category, name: '野菜')
        FactoryBot.create(:tag, name: 'アスパラガス', tag_category: tag_category)
        admin_login
        visit tags_path
        expect(page).to have_content 'アスパラガス'
      end
    end
    context '編集ボタンをクリックした場合' do
      it '編集画面に遷移する' do
        tag_category = FactoryBot.create(:tag_category, name: '野菜')
        tag = FactoryBot.create(:tag, name: 'アスパラガス', tag_category: tag_category)
        admin_login
        visit tags_path
        all('tbody tr')[2].click_on '編集'
        expect(current_path).to eq edit_tag_path(tag.id)
        expect(page).to have_content 'タグ編集'
      end
    end
    context '削除ボタンをクリックした場合' do
      it 'タグが削除され、一覧画面に遷移する' do
        tag_category = FactoryBot.create(:tag_category, name: '野菜')
        tag = FactoryBot.create(:tag, name: 'アスパラガス', tag_category: tag_category)
        admin_login
        visit tags_path
        all('tbody tr')[2].click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '「アスパラガス」を削除しました'
        visit current_path
        expect(current_path).to eq tags_path
        expect(page).not_to have_content 'アスパラガス'
      end
    end
    context 'タグを作成するをクリックした場合' do
      it '新規作成画面に遷移する' do
        tag_category = FactoryBot.create(:tag_category, name: '野菜')
        tag = FactoryBot.create(:tag, name: 'アスパラガス', tag_category: tag_category)
        admin_login
        visit tags_path
        click_link 'タグを作成する'
        expect(current_path).to eq new_tag_path
        expect(page).to have_content 'タグ新規作成'
      end
    end
  end

  describe '新規作成機能のテスト' do
    context 'タグを新規作成した場合' do
      it '登録したタグが表示される' do
        tag_category = FactoryBot.create(:tag_category, name: '野菜')
        admin_login
        visit new_tag_path
        fill_in 'tag_name', with: 'アスパラガス'
        choose '野菜'
        click_on '登録する'
        expect(page).to have_content '「アスパラガス」を作成しました'
        visit current_path
        expect(current_path).to eq tags_path
        expect(page).to have_content 'アスパラガス'
      end
    end
    context '新規作成画面で「戻る」をクリックした場合' do
      it '一覧画面に遷移する' do
        admin_login
        visit new_tag_path
        click_on '戻る'
        expect(current_path).to eq tags_path
      end
    end
  end

  describe '編集機能のテスト' do
    context 'タグを編集した場合' do
      it '投稿内容が更新される' do
        tag_category1 = FactoryBot.create(:tag_category, name: '野菜')
        tag_category2 = FactoryBot.create(:tag_category, name: '肉')
        tag = FactoryBot.create(:tag, name: 'アスパラガス', tag_category: tag_category1)
        admin_login
        visit edit_tag_path(tag.id)
        fill_in 'tag_name', with: '鶏胸肉'
        choose '肉'
        click_on '更新する'
        expect(current_path).to eq tags_path
        expect(page).to have_content 'タグ名を修正しました'
        expect(page).to have_content '鶏胸肉'
        expect(page).not_to have_content 'アスパラガス'
      end
    end
    context '編集画面で「戻る」をクリックした場合' do
      it '一覧画面に遷移する' do
        admin_login
        tag_category = FactoryBot.create(:tag_category, name: '野菜')
        tag = FactoryBot.create(:tag, name: 'アスパラガス', tag_category: tag_category1)
        visit edit_tag_path(tag.id)
        click_on '戻る'
        expect(current_path).to eq tags_path
      end
    end
  end
end
