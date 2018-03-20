FactoryBot.define do

  factory :user do
    id = 1
    sequence(:email) { |n| "#{n}@email.com" }
    password "peterr"
    password_confirmation "peterr"
    admin false
  end

  factory :product_website do
    website_url "www.topman.com"
    price_xpath "//meta[contains(@property,\"price:amount\")]/@content"
    sale_price_xpath "//meta[contains(@property,\"price:amount\")]/@content"
    title_xpath "//meta[contains(@property,\"title\")]/@content"
    image_xpath "//meta[contains(@property,\"image\")]/@content"
  end

  factory :product do
    id = 1
    product_website
    product_url "http://www.topman.com/en/tmuk/product/clothing-140502/mens-trousers-joggers-6608240/black-skinny-joggers-5375215?bi=0&ps=20"
    image_url "http://media.topman.com/wcsstore/TopMan/images/catalog/TM68J04MBLK_Large_F_1.jpg"
    name "Black joggers"
    price "20.00"
    sale_price "10.00"
  end

  factory :product_user do
    product
    user
  end
end
