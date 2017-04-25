require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  before do
    @user = create(:user)
    @product = create(:product, user: @user)
    @purchase = create(:purchase, product: @product, user: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot create a purchase" do
      post :create
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot destroy a purchase" do
      delete :destroy, id: @product
      expect(response).to_not be_success
    end
  end

  before do
    @user2 = create(:user, email: "newuser@gmail.com")
  end
  context "when signed in as the wrong user" do
    before do
      session[:user_id] = @user2.id
    end
    it "should not be able to destroy a purchase" do
      delete :destroy, id: @purchase
      expect(response).to_not be_success
    end
  end
end
