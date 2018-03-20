require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "creating a user" do
    it "can be created if valid" do
      expect(@user).to be_valid
    end

    it "will not be created if email is not valid" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "will not be created if password and password confirmation are not the same" do
      @user.password_confirmation = "hel"
      @user.password = "hello"
      expect(@user).to_not be_valid
    end
  end
end
