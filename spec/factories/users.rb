FactoryBot.define do
  factory :user do
    name { 'デフォルトの名前1' }
    email { 'default1@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
  factory :second_user, class: User do
    name { 'デフォルトの名前2' }
    email { 'default2@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
