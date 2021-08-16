require 'rails_helper'

RSpec.describe 'User', type: :system do

  let!(:general_user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:second_user) }
  # FactoryBot.create(:category)
  # FactoryBot.create(:second_category)
  # FactoryBot.create(:tag)
  # FactoryBot.create(:second_tag)
  # FactoryBot.create(:tag_category)
  # FactoryBot.create(:second_tag_category)

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

  describe 'アカウント登録機能のテスト' do
    context 'アカウント登録をした場合' do
      it 'マイページが表示される' do
        visit new_user_registration_path
        fill_in 'user_name', with: '田中太郎'
        fill_in 'user_email', with: 'tanaka@gmail.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント登録'
        user = User.find_by(email: 'tanaka@gmail.com')
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end
  end

  describe 'ログイン機能のテスト' do
    context '一般ユーザーでログインをした場合' do
      it '一般ユーザーのマイページが表示される' do
        general_login
        expect(current_path).to eq user_path(general_user.id)
        expect(page).to have_content 'ログインしました。'
      end
    end
    context '管理者でログインをした場合' do
      it '管理者のマイページが表示される' do
        admin_login
        expect(current_path).to eq user_path(admin_user.id)
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'ログアウトをした場合' do
      it 'ログイン画面に遷移する' do
        general_login
        click_on 'ログアウト'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'ログアウトしました。'
      end
    end
    context 'アカウント作成ページからゲストログインをした場合' do
      it '料理の一覧画面に遷移する' do
        visit new_user_registration_path
        click_on 'ゲストログイン'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end
    context 'アカウント作成ページから管理者ゲストログインをした場合' do
      it '料理の一覧画面に遷移する' do
        visit new_user_registration_path
        click_on 'ゲストログイン(管理者)'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content '管理者としてログインしました。'
      end
    end
    context 'ログインページからゲストログインした場合' do
      it '料理の一覧画面に遷移する' do
        visit new_user_session_path
        click_on 'ゲストログイン'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end
    context 'ログインページ管理者のゲストログインした場合' do
      it '料理の一覧画面に遷移する' do
        visit new_user_session_path
        click_on 'ゲストログイン(管理者)'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content '管理者としてログインしました。'
      end
    end
    context 'トップページからゲストログインした場合' do
      it '料理の一覧画面に遷移する' do
        visit root_path
        click_on 'ゲストログイン'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end
    context 'トップページ管理者のゲストログインした場合' do
      it '料理の一覧画面に遷移する' do
        visit root_path
        click_on 'ゲストログイン(管理者)'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content '管理者としてログインしました。'
      end
    end
    context 'ログインせずにマイページにとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit user_path(general_user.id)
        expect(current_path).to eq new_user_session_path
      end
    end
#     context 'ログインせずにカテゴリー一覧画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit categories_path
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
#     context 'ログインせずにカテゴリー作成画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit new_category_path
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
#     context 'ログインせずにカテゴリー編集画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit edit_category_path(category1.id)
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
#     context 'ログインせずにタグ一覧画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit tags_path
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
#     context 'ログインせずにタグ作成画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit new_tag_path
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
#     context 'ログインせずにタグ編集画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit edit_tag_path(tag1.id)
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
#     context 'ログインせずにタグカテゴリー一覧画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit tag_categories_path
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
#     context 'ログインせずにタグカテゴリー作成画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit new_tag_category_path
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
#     context 'ログインせずにタグカテゴリー編集画面にとぼうとした場合' do
#       it 'ログイン画面に遷移する' do
#         visit edit_tag_category_path(tag_category1.id)
#         expect(page).to have_content 'ログイン'
#         expect(page).to have_content 'ログインを記憶'
#       end
#     end
  end
end