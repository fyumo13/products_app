require 'rails_helper'

feature "User Settings features" do
  before do
    @user = create(:user)
    log_in
  end

  feature "User Settings Dashboard" do
    before(:each) do
      visit "/users/#{@user.id}/edit"
    end
    scenario "visit user's edit page" do
      expect(page).to have_field("user[first_name]")
      expect(page).to have_field("user[last_name]")
      expect(page).to have_field("user[email]")
      expect(page).to have_field("user[password]")
      expect(page).to have_field("user[password_confirmation]")
    end
    scenario "inputs filled out correctly" do
      expect(find_field("user[first_name]").value).to eq(@user.first_name)
      expect(find_field("user[last_name]").value).to eq(@user.last_name)
      expect(find_field("user[email]").value).to eq(@user.email)
    end
    scenario "incorrectly updates information" do
      fill_in "user[email]", with: "wrong_email"
      click_button "Update Records"
      expect(current_path).to eq("/users/#{@user.id}/edit")
      page.has_content?("Email is invalid")
    end
    scenario "correctly updates information" do
      fill_in "user[email]", with: "newemail@gmail.com"
      click_button "Update Records"
      expect(current_path).to eq("/products")
      page.has_content?("Welcome, #{@user.first_name}")
    end
    scenario "destroys user account and redirects to login/registration page" do
      click_link "Delete Account"
      expect(current_path).to eq("/sessions/new")
    end
  end
end
