require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @user = create(:user)
    @product = create(:product, user: @user)
    @purchase = create(:purchase, product: @product, user: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot create a comment" do
      post :create, id: @product
      expect(response).to redirect_to("/sessions/new")
    end
  end
end
