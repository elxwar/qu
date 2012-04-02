require 'spec_helper'

describe 'user pages' do
  subject {page}
  
  describe "task page (user show)" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}
    
    it {should have_selector('h1', text: user.firstname + " " + user.surname)}
    it {should have_selector('title', text: "Good Task Manager for " + user.firstname + " " + user.surname)}
  end
  
  describe "register" do
    before {visit register_path}
    
    describe "with invalid info" do
      it "shouldnt create a user" do
        expect {click_button "Register"}.not_to change(User, :count)
      end
    end
    
    describe "with valid info" do
      before do
        fill_in "First Name", with: "Eric"
        fill_in "Surname", with: "Waring"
        fill_in "Email", with: "eric@the-feel.co.uk"
        fill_in "Password", with: "secret"
        fill_in "Confirm Password", with: "secret"
      end
      
      it "should create a user" do
        expect do
          click_button "Register"
        end.to change(User, :count).by(1)
      end
    end
    
  end
end
