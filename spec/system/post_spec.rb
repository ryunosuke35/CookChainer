require 'rails_helper'

RSpec.describe 'Post', type: :system do

  let!(:general_user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:second_user) }
  let!(:post1) { FactoryBot.create(:post, user: general_user) }
  let!(:post2) { FactoryBot.create(:second_post, user: general_user) }

  



  # describe 'ログインせずに画面遷移した際のテスト' do
  #   context 'ログインせずに料理一覧画面にとんだ場合' do
  #     it '料理の一覧画面に遷移する' do
  #       visit index2_posts_path
  #       expect(current_path).to eq index2_posts_path
  #     end
  #   end
  #   context 'ログインせずに料理の詳細画面にとんだ場合' do
  #     it 'ログイン画面に遷移する' do
  #       visit post_path(post1.id)
  #       expect(current_path).to eq post_path(post1.id)
  #       expect(page).to have_content 'デフォルトの料理名1'
  #     end
  #   end
  #   context 'ログインせずに料理の投稿画面にとぼうとした場合' do
  #     it 'ログイン画面に遷移する' do
  #       visit new_post_path
  #       expect(current_path).to eq new_user_session_path
  #     end
  #   end
  #   context 'ログインせずに料理の編集画面にとぼうとした場合' do
  #     it 'ログイン画面に遷移する' do
  #       visit edit_post_path(post1.id)
  #       expect(current_path).to eq new_user_session_path
  #     end
  #   end
  #   context 'ログインせずに料理の記録画面にとぼうとした場合' do
  #     it 'ログイン画面に遷移する' do
  #       visit posts_path
  #       expect(current_path).to eq new_user_session_path
  #     end
  #   end
  # end
end
