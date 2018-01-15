describe InitialWebScrape do

  before do
    product = FactoryGirl.create(:product)
    @iws = InitialWebScrape.new(product: product)
  end

  it "correctly formats the price ready for inputting in Products" do
    price = " price £989.00"
    assert_equal("989.00", @iws.correct_price_format(price))
  end
end
