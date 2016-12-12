require 'spec_helper'
require 'rails_helper'

feature "user goals" do
  subject(:bob) { FactoryGirl.create(:user) }
  let(:goal1) { FactoryGirl.create(:goal) }
  let(:goal2) { FactoryGirl.create(:complete_goal) }
  let(:goal3) { FactoryGirl.create(:private_goal) }

  feature "when logged in" do
    before(:each) do
      visit new_session_url
      fill_in("Username", with: bob.username)
      fill_in("Password", with: bob.password)
      click_button("Sign In")


    end

    scenario "displays the user's goals" do
      expect(page).to have_content("#{bob.username}'s Goals")
      expect(page).to have_content(goal1.description)
      expect(page).to have_content(goal2.description)
      expect(page).to have_content(goal3.description)
    end

    scenario "shows status of goals" do
      expect(page).to have_content("Completed Goals")
    end

    scenario "lets users change goal status" do
      expect(page).to have_button("Mark as Complete")
    end

    scenario "lets users create new goal" do
      expect(page).to have_link("Add Goal")
    end

    scenario "lets users delete goals" do
      expect(page).to have_button("Delete Goal")
    end
  end

  feature "when not logged in" do

    scenario "displays a user's public goals" do
      expect(page).to have_content("#{bob.username}'s Goals")
      expect(page).to have_content(goal1.description)
      expect(page).to have_content(goal2.description)
    end

    scenario "doesn't display a user's private goals" do
      expect(page).to_not have_content(goal3.description)
    end

    scenario "doesn't allow creating, editing, or deleting" do
      expect(page).to_not have_button("Delete Goal")
      expect(page).to_not have_link("Add Goal")
      expect(page).to_not have_button("Mark as Complete")

    end
  end

end

feature "goal index" do

  scenario "lists all public goals" do
    visit goals_url
    expect(page).to have_content(goal1.description)
    expect(page).to have_content(goal2.description)
    expect(page).to_not have_content(goal3.description)
  end
end

feature "goal show page" do

  scenario "cannot see a private goal if not the goal's owner" do
    visit goal_url(goal3.id)
    expect(page).to have_content("Goals Index")
  end

  scenario "has a description of the goal" do
    visit goal_url(goal2)
    expect(page).to have_content(goal2.description)
  end

  scenario "has the status of the goal" do
    visit goal_url(goal2)
    expect(page).to have_content("COMPLETE")
  end
end
