FactoryGirl.define do
  factory :user do
    email "Hi"
    password "helloo"
    password_confirmation "helloo"
  end

  factory :product_website do
    website_url "www.topman.com"
    product_price_name "og:price:amount"
    now_price_name "og:price:amount"
  end

  factory :product do
    product_url "http://www.topman.com/en/tmuk/product/clothing-140502/mens-trousers-joggers-6608240/black-skinny-joggers-5375215?bi=0&ps=20"
    name "Black joggers"
    price "20.00"
    product_website
    user
  end
end
