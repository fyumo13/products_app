require 'rails_helper'
feature "User features" do
  feature "user registration" do
    before(:each) do
      visit "/sessions/new"
    end
    scenario "visits registration page" do
      expect(page).to have_field("user[first_name]")
      expect(page).to have_field("user[last_name]")
      expect(page).to have_field("user[email]")
      expect(page).to have_field("user[password]")
      expect(page).to have_field("user[password_confirmation]")
    end
    scenario "with improper inputs, redirects back to registration page" do
      click_button "Register"
      expect(current_path).to eq("/sessions/new")
      page.has_content?("can't be blank")
    end
  end

  feature "user login" do
    before(:each) do
      visit "/sessions/new"
    end
    scenario "visits login page" do
      expect(page).to have_field("email")
      expect(page).to have_field("password")
    end
    scenario "with improper inputs, redirects back to login page and shows validations" do
      click_button "Log In"
      expect(current_path).to eq("/sessions/new")
      page.has_content?("Invalid email/password combination")
    end
  end
end
