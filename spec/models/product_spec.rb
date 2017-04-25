require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @user = create(:user)
  end

  context "with valid attributes" do
    it "should save" do
      expect(build(:product, user: @user)).to be_valid
    end
  end

  context "with invalid attributes should not save if" do
    it "name is blank" do
      expect(build(:product, user: @user, name: '')).to be_invalid
    end
    it "name is not unique" do
      create(:product, user: @user)
      expect(build(:product, user: @user)).to be_invalid
    end
    it "price is blank" do
      expect(build(:product, user: @user, price: '')).to be_invalid
    end
    it "price is not in correct format" do
      @product = create(:product, user: @user, price: 2.9065)
      expect(@product.price).to eq(2.91)
    end
    it "price is negative" do
      expect(build(:product, user: @user, price: -1.00)).to be_invalid
    end
    it "description is blank" do
      expect(build(:product, user: @user, description: '')).to be_invalid
    end
  end

  context "relationships" do
    before do
      @product = create(:product, user: @user)
    end
    it "belongs to a user" do
      expect(@product.user).to eq(@user)
    end
  end
end
