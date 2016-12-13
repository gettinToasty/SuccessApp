require 'spec_helper'
require 'rails_helper'

feature "adding comments" do
  let(:bob) { FactoryGirl.create(:user) }
  let(:comment) { FactoryGirl.create(:comment, owner: bob) }
  let(:goal) { FactoryGirl.create(:goal, user: bob) }
  let(:sally) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_session_url
    fill_in("Username", with: bob.username)
    fill_in("Password", with: bob.password)
    click_button("Sign In")
  end

  scenario "when on user's page" do

    visit user_url(sally)
    fill_in("Comment", with: comment.body)
    click_button("Add Comment")
    expect(page).to have_content(comment.body)
  end

  scenario "when on goal's page" do

    visit goal_url(goal)
    fill_in("Comment", with: comment.body)
    click_button("Add Comment")
    expect(page).to have_content(comment.body)
  end
end

feature "removing comments" do
  let(:bob) { FactoryGirl.create(:user) }
  let(:comment) { FactoryGirl.create(:comment, owner: bob) }
  let(:sally) { FactoryGirl.create(:user) }
  let(:goal) { FactoryGirl.create(:goal, user: bob) }

  before(:each) do
    visit new_session_url
    fill_in("Username", with: bob.username)
    fill_in("Password", with: bob.password)
    click_button("Sign In")
  end

  scenario "when on user's page" do

    visit user_url(sally)
    fill_in("Comment", with: comment.body)
    click_button("Add Comment")
    expect(page).to have_content(comment.body)
    expect(page).to have_button("Remove Comment")
  end

  scenario "when on goal's page" do

    visit goal_url(goal)
    fill_in("Comment", with: comment.body)
    click_button("Add Comment")
    expect(page).to have_content(comment.body)
    expect(page).to have_button("Remove Comment")
  end
end
