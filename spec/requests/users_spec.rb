require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should_not have_title('All Users') }
    it { should_not have_content('All Users') }
    it { should_not have_link('Delete') }

    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end

      it { should have_title('All Users') }
      it { should have_content('All Users') }
      it { should have_link('Delete', href: user_path(User.first)) }
      it { should_not have_link('Delete', href: user_path(admin)) }

      it "should list each user" do
        User.all.each do |user|
          expect(page).to have_selector('td', text: user.name)
        end
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Create Account') }
    it { should have_title('Create Account') }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Save" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign Out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert-box.success', text: 'Welcome') }
      end
    end
    describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit edit_user_path(user)
      end

      describe "page" do
        it { should have_content("Edit Details") }
        it { should have_title("Edit Details") }
      end

      describe "with invalid information" do
        before { click_button "Save" }

        it { should have_content('error') }
      end

      describe "with valid information" do
        let(:new_name) { "New Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in "Name",         with: new_name
          fill_in "Email",        with: new_email
          fill_in "Password",     with: user.password
          fill_in "Confirm Password", with: user.password
          click_button "Save"
        end

        it { should have_title(new_name) }
        it { should have_selector('div.alert-box.success') }
        it { should have_link('Sign Out', href: signout_path) }
        specify { expect(user.reload.name).to eq new_name }
        specify { expect(user.reload.email).to eq new_email }
      end
    end
  end
end