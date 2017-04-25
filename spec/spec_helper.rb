def log_in email: "email@gmail.com", password: "password"
  visit "/" unless current_path == "/"
  fill_in "email", with: email
  fill_in "password", with: password
  click_button "Log In"
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
