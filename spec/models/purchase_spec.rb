require 'rails_helper'

RSpec.describe Purchase, type: :model do
  context "relationships" do
    before do
      @user = create(:user)
      @product = create(:product, user: @user)
      @purchase = create(:purchase, user: @user, product: @product)
    end
    it "belongs to a user" do
      expect(@purchase.user).to eq(@user)
    end
    it "belongs to a product" do
      expect(@purchase.product).to eq(@product)
    end
  end
end
