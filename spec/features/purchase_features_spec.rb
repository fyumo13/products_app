require 'rails_helper'

feature "Purchase features" do
  before do
    @user = create(:user)
    @user2 = create(:user, email: "newuser@gmail.com")
    @product = create(:product, user: @user2)
    log_in
  end

  feature "product has not been purchased" do
    before(:each) do
      visit "/products"
    end
    scenario "Buy button is visible" do
      expect(page).to have_button("Buy")
    end
  end

  feature "product has been purchased" do
    before do
      @purchase = create(:purchase, user: @user, product: @product)
    end
    before(:each) do
      visit "/products"
    end
    scenario "Cancel Purchase button is visible" do
      expect(page).to have_button("Cancel Purchase")
    end
    scenario "clicking Cancel Purchase button will replace with Buy button" do
      click_button "Cancel Purchase"
      expect(page).not_to have_button("Cancel Purchase")
      expect(page).to have_button("Buy")
    end
  end
end
