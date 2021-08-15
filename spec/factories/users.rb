FactoryBot.define do
  factory :user do
    name { '一般ユーザー' }
    email { 'general_user@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end
  factory :second_user, class: User do
    name { '管理者' }
    email { 'admin@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end
end
