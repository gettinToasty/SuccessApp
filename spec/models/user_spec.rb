require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl.build(:user) }

  describe "validations" do

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }

    it { should validate_presence_of(:password_digest) }

    it { should validate_presence_of(:session_token) }

    it { should validate_length_of(:password).is_at_least(6) }

  end

  describe "associations" do

    it { should have_many(:goals) }
    it { should have_many(:comments) }

  end

  describe ".find_by_credentials" do

    context "with valid credentials" do

      it "returns a user" do
        user = FactoryGirl.build(:user)
        user.save
        expect(User.find_by_credentials(user.username, user.password)).to be_a(User)
      end
    end


    context "with invalid credentials" do

      it "returns nil" do
        expect(User.find_by_credentials("Bob", "bobroolz")).to be_nil

      end
    end

  end

  describe '#reset_session_token!' do

    it "resets the session token" do
      user = FactoryGirl.create(:user)
      old_token = user.session_token
      user.reset_session_token!

      expect(user.session_token).to_not eq(old_token)
    end
  end

  describe '#ensure_session_token' do

    it { expect(FactoryGirl.build(:user).session_token).to_not be_nil }
  end

  describe '#password=' do
    it "doesn't save the password to the database" do
      user = FactoryGirl.create(:user)

      expect(User.find(user.id).password).to be_nil
    end

    it "sets the password digest" do
      user = FactoryGirl.create(:user)

      expect(user.password_digest).to_not be_nil
    end
  end

end
