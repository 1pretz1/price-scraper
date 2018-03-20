describe InitialScrape do

  let(:product) { create(:product) }
  let(:user) { create(:user) }
  let(:website) { create(:product_website) }

  before do
    user_agent = 'Mozilla/6.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7)
                  Gecko/2009021910 Firefox/3.0.7'
    page = Nokogiri::HTML(open(product.product_url, 'User-agent' => user_agent), nil, 'UTF-8').remove_namespaces!
    @iws = InitialScrape.new(product_url: product.product_url, page: page, user: user, website: website)
  end

  it "correctly formats the price ready for inputting in Products" do
    price = " price £989.00"
    assert_equal("989.00", @iws.correct_price_format(price))
  end
end
