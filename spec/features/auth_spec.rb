require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in("Username", with: "Bob")
      fill_in("Password", with: "bobroolz")
      click_button("Sign Up")
      expect(page).to have_content("Bob")
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in("Username", with: "Bob")
    fill_in("Password", with: "bobroolz")
    click_button("Sign In")
    expect(page).to have_content("Bob")
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit root_url
    expect(page).to have_link("Sign In")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in("Username", with: "Bob")
    fill_in("Password", with: "bobroolz")
    click_button("Sign In")
    expect(page).to have_content("Bob")

    click_button("Sign Out")
    expect(page).to_not have_content("Bob")
  end

end
