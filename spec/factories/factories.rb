FactoryGirl.define do

  #factory :page do

  factory :user do
    email "peter"
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
    user
    product_website
    product_url "http://www.topman.com/en/tmuk/product/clothing-140502/mens-trousers-joggers-6608240/black-skinny-joggers-5375215?bi=0&ps=20"
    name "Black joggers"
    price "20.00"
    sale_price "10.00"
  end
end
