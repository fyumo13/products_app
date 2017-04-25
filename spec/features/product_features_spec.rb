require 'rails_helper'

feature "Product features" do
  before do
    @user = create(:user)
    @user2 = create(:user, email: "newuser@gmail.com")
    log_in
    @product = create(:product, user: @user)
    @product2 = create(:product, name: "Test", user: @user2)
  end

  feature "Products Dashboard" do
    before(:each) do
      visit "/products"
    end
    scenario "displays all products" do
      expect(page).to have_text(@product.name)
      expect(page).to have_text(@product2.name)
    end
    scenario "create a new product" do
      fill_in "product[name]", with: "New Product"
      fill_in "product[description]", with: "Product description"
      fill_in "product[price]", with: 5.67
      click_button "Add Product"
      expect(current_path).to eq("/products")
      expect(page).to have_text("New Product")
    end
    scenario "clicking Edit button leads to Edit Product page" do
      click_link "Edit"
      expect(current_path).to eq("/products/#{@product.id}/edit")
    end
    scenario "destroy a product" do
      click_link "Delete"
      expect(current_path).to eq("/products")
      expect(page).not_to have_text(@product.name)
    end
  end

  feature "Products show page" do
    before(:each) do
      visit "/products/#{@product2.id}"
    end
    scenario "displays correct information" do
      expect(page).to have_text(@product2.name)
      expect(page).to have_text(@product2.price)
      expect(page).to have_text(@product2.description)
      expect(page).to have_text(@product2.user.first_name)
      expect(page).to have_text(@product2.user.last_name)
    end
    scenario "displays Buy button" do
      expect(page).to have_button("Buy")
    end
  end

  feature "Edit Product page" do
    before(:each) do
      visit "/products/#{@product.id}/edit"
    end
    scenario "visit product's edit page" do
      expect(page).to have_field("product[name]")
      expect(page).to have_field("product[description]")
      expect(page).to have_field("product[price]")
    end
    scenario "incorrectly updates information" do
      click_button "Update Product"
      expect(current_path).to eq("/products/#{@product.id}/edit")
      page.has_content?("can't be blank")
    end
    scenario "correctly updates information" do
      fill_in "product[name]", with: "Updated Product Name"
      fill_in "product[description]", with: "Updated description"
      fill_in "product[price]", with: 7.99
      click_button "Update Product"
      expect(current_path).to eq("/products/#{@product.id}")
    end
  end
end
