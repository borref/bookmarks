FactoryBot.define do
  factory :bookmark do
    transient do
      site { create(:site) }
    end

    url 'https://github.com/thoughtbot'
    title 'forbidden'
    shortening 'https://goo.gl'
    site_id { site.id }
  end
end
