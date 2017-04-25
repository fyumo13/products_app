require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:user)
  end
  context "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access edit" do
      get :edit, id: @user
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access update" do
      patch :update, id: @user
      expect(response).to redirect_to("/sessions/new")
    end
    it "cannot access destroy" do
      delete :destroy, id: @user
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
    it "cannot access the edit page of another user" do
      get :edit, id: @user
      expect(response).to redirect_to("/products")
    end
    it "cannot update another user's information" do
      patch :update, id: @user
      expect(response).to_not be_success
    end
    it "cannot destroy another user" do
      delete :destroy, id: @user
      expect(response).to_not be_success
    end
  end
end
