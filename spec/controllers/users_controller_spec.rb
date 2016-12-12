require 'rails_helper'

begin
  UsersController
rescue
  UsersController = nil
end

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the new user page" do
      get :new
      should render_template(:new)
    end
  end

  describe "POST #create" do
    it "redirects to the home page with valid parameters" do
      post :create, user: { username: "Bob", password: "bobroolz" }
      should redirect_to(root_url)
    end

    it "renders new page with errors if user is invalid" do
      post :create, user: { username: "Bob" }
      should render_template(:new)
      should set_flash.now[:errors]
    end
  end

  describe "GET #show" do
    it "renders the show page" do
      user = FactoryGirl.build(:user)
      user.save
      get :show, { id: user.id }
      should render_template(:show)
    end
  end
end
