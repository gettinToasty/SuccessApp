require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  subject(:bob) { FactoryGirl.create(:user) }

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do
    let(:sally) { FactoryGirl.build(:user) }

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in("Username", with: sally.username)
      fill_in("Password", with: sally.password)
      click_button("Sign Up")
      expect(page).to have_content(sally.username)
    end

  end

end

feature "logging in" do
  subject(:bob) { FactoryGirl.create(:user) }

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in("Username", with: bob.username)
    fill_in("Password", with: bob.password)
    click_button("Sign In")
    expect(page).to have_content(bob.username)
  end

end

feature "logging out" do
  subject(:bob) { FactoryGirl.create(:user) }

  scenario "begins with a logged out state" do
    visit root_url
    expect(page).to have_link("Sign In")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in("Username", with: bob.username)
    fill_in("Password", with: bob.password)
    click_button("Sign In")
    expect(page).to have_content(bob.username)

    click_button("Sign Out")
    expect(page).to_not have_content(bob.username)
  end

end
