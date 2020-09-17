require 'rails_helper'

describe ProductsController do
  describe "GET #new" do
    it "returns new product url page" do
      expect(get 'new').to render_template :new
    end
  end
end
