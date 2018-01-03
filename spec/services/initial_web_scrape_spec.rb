describe InitialWebScrape do

  it "correctly formats the price ready for inputting in Products" do
    price_text = " price £989.00"
    assert_equal("989.00", correct_price_format(price_text))
  end
end
