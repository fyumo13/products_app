require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "requires content" do
    expect(build(:comment, content: '')).to be_invalid
  end

  context "relationships" do
    before do
      @user = create(:user)
      @product = create(:product, user: @user)
      @comment = create(:comment, user: @user, product: @product)
    end
    it "belongs to a user" do
      expect(@comment.user).to eq(@user)
    end
    it "belongs to a product" do
      expect(@comment.product).to eq(@product)
    end
  end
end
