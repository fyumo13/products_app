require 'rails_helper'

feature "Authentication feature" do
  before do
    @user = create(:user)
    visit "/sessions/new"
  end

  feature "user attempts to sign-in" do
    scenario "visits login and registration page" do
      expect(page).to have_field('email')
      expect(page).to have_field('password')
    end
    scenario "logs in user if email/password combination is valid" do
      log_in
      expect(current_path).to eq("/products")
      expect(page).to have_content("Welcome, #{@user.first_name}")
    end
    scenario "does not sign in user if email is not found" do
      log_in email: "notemail@gmail.com"
      expect(current_path).to eq("/sessions/new")
      page.has_content?("Invalid email/password combination")
    end
    scenario "does not sign in user if email/password combination is invalid" do
      log_in password: "notpassword"
      expect(current_path).to eq("/sessions/new")
      page.has_content?("Invalid email/password combiation")
    end
  end

  feature "user attempts to log out" do
    before do
      log_in
    end
    scenario "displays 'Log Out' button when user is logged in" do
      expect(page).to have_button("Log Out")
    end
    scenario "logs out user and redirects to login/registration page" do
      click_button "Log Out"
      expect(current_path).to eq("/sessions/new")
    end
  end
end
