require 'rails_helper'

RSpec.describe 'Category', type: :system do

  let!(:general_user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:second_user) }

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



end
