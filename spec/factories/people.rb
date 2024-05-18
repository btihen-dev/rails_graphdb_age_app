FactoryBot.define do
  factory :person do
    nick_name { 'Musterstrasse 1' }
    first_name { 'Musterstrasse 1' }
    given_name { 'Musterstrasse 1' }
    last_name { 'Musterstrasse 1' }
    gender { %w[male female].sample }
  end
end
