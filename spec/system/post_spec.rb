require 'rails_helper'

RSpec.describe 'Post', type: :system do

  let!(:general_user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:second_user) }
  let!(:post1) { FactoryBot.create(:post, user: general_user) }
  let!(:post2) { FactoryBot.create(:second_post, user: general_user) }
  let!(:level1) { FactoryBot.create(:level_setting) }
  let!(:level2) { FactoryBot.create(:second_level_setting) }
  let!(:level3) { FactoryBot.create(:third_level_setting) }
  let!(:category1) { FactoryBot.create(:category) }
  let!(:category2) { FactoryBot.create(:second_category) }
  let!(:post_cateory1) { FactoryBot.create(:post_category, post: post1, category: category1 ) }
  let!(:post_cateory2) { FactoryBot.create(:second_post_category, post: post2, category: category2) }
  let!(:tag1) { FactoryBot.create(:tag, tag_category: tag_category1) }
  let!(:tag2) { FactoryBot.create(:second_tag, tag_category: tag_category1) }
  let!(:post_tag1) { FactoryBot.create(:post_tag, post: post1, tag: tag1) }
  let!(:post_tag2) { FactoryBot.create(:second_post_tag, post: post2, tag: tag2) }
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

  def test_post1
    visit new_post_path
    fill_in 'post_name', with: 'だしなし簡単！肉じゃがの基本レシピ作り方'
    fill_in 'post_url', with: 'https://www.sirogohan.com/recipe/nikujaga/'
    fill_in 'post_memo', with: '醤油は少なめにしたほうがよさそう'
    attach_file 'post_image', "#{Rails.root}/spec/fixtures/image/top1.jpg"
    click_button 'デフォルトのタグカテゴリー1'
    check '牛肉'
    check '鶏肉'
    click_button 'デフォルトのタグカテゴリー1'
    page.all(".category_select input")[0].click
    click_on '登録する'
  end


  describe 'ログインせずに画面遷移した際のテスト' do
    context 'ログインせずに料理一覧画面にとんだ場合' do
      it '料理の一覧画面に遷移する' do
        visit index2_posts_path
        expect(current_path).to eq index2_posts_path
      end
    end
    context 'ログインせずに料理の詳細画面にとんだ場合' do
      it 'ログイン画面に遷移する' do
        visit post_path(post1.id)
        expect(current_path).to eq post_path(post1.id)
        expect(page).to have_content 'デフォルトの料理名1'
      end
    end
    context 'ログインせずに料理の投稿画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit new_post_path
        expect(current_path).to eq new_user_session_path
      end
    end
    context 'ログインせずに料理の編集画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit edit_post_path(post1.id)
        expect(current_path).to eq new_user_session_path
      end
    end
    context 'ログインせずに料理の記録画面にとぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit posts_path
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe '新規作成機能のテスト' do
    context '新規投稿した場合' do
      it '一覧画面に遷移し、投稿内容が表示される' do
        FactoryBot.create(:tag, name: '牛肉', tag_category: tag_category1)
        FactoryBot.create(:second_tag, name: '鶏肉', tag_category: tag_category1)
        general_login
        visit new_post_path
        fill_in 'post_name', with: 'だしなし簡単！肉じゃがの基本レシピ作り方'
        fill_in 'post_url', with: 'https://www.sirogohan.com/recipe/nikujaga/'
        fill_in 'post_memo', with: '醤油は少なめにしたほうがよさそう'
        attach_file 'post_image', "#{Rails.root}/spec/fixtures/image/top1.jpg"
        click_button 'デフォルトのタグカテゴリー1'
        check '牛肉'
        check '鶏肉'
        click_button 'デフォルトのタグカテゴリー1'
        page.all(".category_select input")[0].click
        click_on '登録する'
        expect(current_path).to eq posts_path
        expect(page).to have_content 'だしなし簡単！肉じゃがの基本レシピ作り方'
        expect(page).to have_content '牛肉'
        expect(page).to have_content '鶏肉'
      end
    end
  end

  describe '料理の詳細画面のテスト' do
    context '「戻る」をクリックした場合' do
      it '記録画面に遷移する' do
        general_login
        visit post_path(post1.id)
        click_link '戻る'
        expect(current_path).to eq posts_path
      end
    end
    context '「削除する」をクリックした場合' do
      it '記録画面に遷移する' do
        general_login
        visit post_path(post1.id)
        click_link '削除する'
        page.driver.browser.switch_to.alert.accept
        visit current_path
        expect(current_path).to eq posts_path
        expect(page).not_to have_content 'デフォルトの料理名1'
      end
    end
    context '「編集する」をクリックした場合' do
      it '編集画面に遷移する' do
        general_login
        visit post_path(post1.id)
        click_link '編集する'
        expect(current_path).to eq edit_post_path(post1.id)
        expect(page).not_to have_content 'デフォルトの料理名1'
      end
    end
  end

  describe '料理の編集画面のテスト' do
    context '「更新する」をクリックした場合' do
      it '記録画面に遷移し、内容が更新される' do
        general_login
        visit edit_post_path(post1.id)
        fill_in 'post_name', with: 'デフォルトの料理名1(編集済み)'
        fill_in 'post_memo', with: 'デフォルトのメモ1(編集済み)'
        click_button 'デフォルトのタグカテゴリー1'
        uncheck 'デフォルトのタグ1'
        check 'デフォルトのタグ2'
        page.all(".category_select input")[1].click
        click_on '更新する'
        expect(current_path).to eq posts_path
        expect(page).to have_content '投稿内容を編集しました!'
        expect(page).to have_content 'デフォルトの料理名1(編集済み)'
      end
    end
    context '「戻る」をクリックした場合' do
      it '記録画面に遷移し、内容が更新される' do
        general_login
        visit edit_post_path(post1.id)
        click_on '戻る'
        expect(current_path).to eq post_path(post1.id)
        expect(page).to have_content 'デフォルトの料理名1'
      end
    end
  end

  describe '料理の記録画面のテスト' do
    context '料理名をクリックした場合' do
      it '詳細画面に遷移し、投稿内容が表示される' do
        general_login
        visit posts_path
        click_link 'デフォルトの料理名1'
        expect(current_path).to eq post_path(post1.id)
        expect(page).to have_content 'デフォルトの料理名1'
      end
    end
  end

  describe '料理の一覧画面のテスト' do
    context '料理名をクリックした場合' do
      it '詳細画面に遷移し、投稿内容が表示される' do
        visit index2_posts_path
        click_link 'デフォルトの料理名1'
        expect(current_path).to eq post_path(post1.id)
        expect(page).to have_content 'デフォルトの料理名1'
      end
    end
    context 'タイトル検索をした場合' do
      it '検索内容を含む料理のみが表示される' do
        visit index2_posts_path
        fill_in 'q_name_cont', with: '料理名1'
        click_on '検索'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content 'デフォルトの料理名1'
        expect(page).not_to have_content 'デフォルトの料理名2'
      end
    end
    context 'カテゴリ検索をした場合' do
      it 'カテゴリに含まれる料理のみが表示される' do
        visit index2_posts_path
        select 'デフォルトのカテゴリー1', from: 'category_id'
        click_on '検索する'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content 'デフォルトの料理名1'
        expect(page).not_to have_content 'デフォルトの料理名2'
      end
    end
    context 'タグ検索をした場合' do
      it 'タグが含まれる料理のみが表示される' do
        visit index2_posts_path
        find(:xpath, '//*[@id="accordion"]/li/div[1]').click
        click_on 'デフォルトのタグ1'
        expect(current_path).to eq index2_posts_path
        expect(page).to have_content 'デフォルトの料理名1'
        expect(page).not_to have_content 'デフォルトの料理名2'
      end
    end
  end

  describe '経験値・レベルアップ機能のテスト' do
    context '料理を投稿した場合' do
      it '記録画面に遷移し、経験値が上がる' do
        FactoryBot.create(:tag, name: '牛肉', tag_category: tag_category1)
        FactoryBot.create(:second_tag, name: '鶏肉', tag_category: tag_category1)
        general_login
        test_post1
        expect(current_path).to eq posts_path
        expect(page).to have_content 'だしなし簡単！肉じゃがの基本レシピ作り方'
        expect(page).to have_content '5/15'
        expect(page).to have_content '33%'
      end
    end
    context '料理を必要回数投稿した場合' do
      it 'レベルが上がる' do
        FactoryBot.create(:tag, name: '牛肉', tag_category: tag_category1)
        FactoryBot.create(:second_tag, name: '鶏肉', tag_category: tag_category1)
        general_login
        test_post1
        test_post1
        test_post1
        expect(current_path).to eq posts_path
        expect(page).to have_content 'Lv.2'
      end
    end
  end
end
