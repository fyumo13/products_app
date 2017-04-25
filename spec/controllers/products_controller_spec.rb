require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before do
    @user = create(:user)
    @product = create(:product, user: @user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access index" do
      get :index
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access create" do
      post :create
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      delete :destroy, id: @product
      expect(response).to redirect_to("/sessions/new")
    end
  end

  before do
    @user2 = create(:user, email: "newuser@gmail.com")
  end
  context "when signed in as the wrong user" do
    before do
      session[:user_id] = @user2.id
    end
    it "cannot destroy another user's product" do
      delete :destroy, id: @product
      expect(response).to_not be_success
    end
  end
end
