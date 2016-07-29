FactoryGirl.define do
  factory :user, class: User do
    name "Bobbbbbbb user"
    email "person@appfolio.com"
    password "password"
    password_confirmation "password"
    confirmed_at "2015-07-29 00:04:34"
  end

  factory :user_with_tables_prefix, class: User do
    name "Cool user"
    email "im@appfolio.com"
    password "password"
    password_confirmation "password"
    confirmed_at "2015-07-29 00:04:34"
    tables_prefix "123456788"
  end
end
