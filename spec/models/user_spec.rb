# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  firstname  :string(255)
#  surname    :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(firstname: "Eric", surname: "Waring", email: "ericw@the-feel.co.uk", password: "secret",
      password_confirmation: "secret")}
  
  subject {@user}
  
  it {should respond_to(:firstname)}
  it {should respond_to(:surname)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}
  
  it {should be_valid}
  
  describe "when firstname is missing" do
    before { @user.firstname = " "}
    it {should_not be_valid}
  end
  
  describe "when surname is missing" do
    before { @user.surname = " "}
    it {should_not be_valid}
  end
  
  describe "when email is missing" do
    before { @user.email = " "}
    it {should_not be_valid}
  end
  
  describe "when email is invalid" do
    it "should be invalid" do
      emails = %w[eric@the-feel,co.uk eric_at_the-feel.co.uk eric@the-feel.]
      emails.each do |invalid_email|
        @user.email = invalid_email
        @user.should_not be_valid        
      end
    end
  end
  
  describe "when email is valid" do
    it "should be valid" do
      emails = %w[eric@the-feel.co.uk eric@the-feel.com eric.waring@the-feel.com]
      emails.each do |valid_email|
        @user.email = valid_email
        @user.should be_valid        
      end
    end
  end
  
  describe "when email address is not unique" do
    before do
      same_email_user = @user.dup
      same_email_user.email = @user.email.upcase
      same_email_user.save
    end
    
    it {should_not be_valid}
  end
  
  describe "when password is missing" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end
  
  describe "when password does not match confirmation" do
    before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end
  
  describe "authenticate method returns" do
    before { @user.save}
    let (:found_user) {User.find_by_email(@user.email)}
    
    describe "with valid password" do
      it {should == found_user.authenticate(@user.password)}
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) {found_user.authenticate("invalid")}
      it {should_not == user_for_invalid_password}
      specify { user_for_invalid_password.should be_false}
    end
  end
end
