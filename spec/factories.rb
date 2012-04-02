FactoryGirl.define do
  factory :user do
    firstname               "Eric"
    surname                 "Waring"
    email                   "ericw@the-feel.co.uk"
    password                "secret"
    password_confirmation   "secret"
  end
end