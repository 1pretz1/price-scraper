class CheckPriceScrape < InitialWebScrape
attr_accessor :user_agent

  def initialize
    @user_agent = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7"
  end

  def self.call(*args)
    new(*args).call
  end

  def call
  end

  def webpage
    Product.all.each do |product|
      web_page
  end

end
