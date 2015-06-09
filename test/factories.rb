FactoryGirl.define do
  factory :user do
    name "Bobbbbbbb user"
    email "person@appfolio.com"
    encrypted_password "password"
    password_confirmation "password"
  end

  factory :user_with_tables_prefix, class: User do
    name "Cool user"
    email "im@appfolio.com"
    encrypted_password "password"
    password_confirmation "password"
    tables_prefix "123456788"
  end
end
