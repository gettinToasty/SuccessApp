require 'spec_helper'
require 'rails_helper'

feature "user goals" do
  subject(:bob) { FactoryGirl.create(:user) }

  feature "when logged in" do
    before(:each) do
      visit new_session_url
      fill_in("Username", with: bob.username)
      fill_in("Password", with: bob.password)
      click_button("Sign In")
      
    end

    scenario "displays the user's goals" do
      expect(page).to have_content("#{bob.username}'s Goals")
    end

    scenario "shows status of goals"

    scenario "lets users change goal status"

    scenario "lets users create new goal"

    scenario "lets users delete goals"
  end

  feature "when not logged in" do

    scenario "displays a user's public goals"

    scenario "doesn't display a user's private goals"

    scenario "doesn't allow creating, editing, or deleting"
  end

end

feature "goal index" do

  scenario "lists all public goals"
end

feature "goal show page" do

  scenario "cannot see a private goal if not the goal's owner"

  scenario "has a description of the goal"

  scenario "has the status of the goal"
end
