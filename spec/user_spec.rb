require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    subject {
      described_class.new(
        first_name: "Jason",
        last_name: "Park",
        email: "zeipar@gmail.com",
        password: "pwdpwd",
        password_confirmation: "pwdpwd"
      )
    }

    it "valid with all necessary attributes" do
      expect(subject).to be_valid
    end

    it "is not valid with null first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with null last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with null email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with null password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid when pwd and pwd confirmation do not match" do
      subject.password_confirmation = "different"
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")

    end

    it "is not valid with password less than 6 characters" do
      subject.password = 'pwd'
      subject.password_confirmation = 'pwd'
      expect(subject).to_not be_valid
    end
     
    it 'is not valid with case sensitive emails for registration' do
      @user1 = User.create(first_name: "tester1", last_name: "erer", email: "zeipar@gmail.com", password: "lalala", password_confirmation: "lalala")
      @user2 = User.create(first_name: "tester2", last_name: "erer", email: "ZEIPAR@GMAIL.com", password: "lalala", password_confirmation: "lalala")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here

    it "User is equal to authenticated user" do
      User.create(first_name: "tester1", last_name: "erer", email: "zeipar@gmail.com", password: "lalala", password_confirmation: "lalala")
      @user = User.authenticate_with_credentials("zeipar@gmail.com", "lalala")

      expect(@user).to be_an_instance_of(User)
    end

    it "is valid with whitespaces padding the email address" do
      User.create(first_name: "tester1", last_name: "erer", email: "zeipar@gmail.com", password: "lalala", password_confirmation: "lalala")
      @user = User.authenticate_with_credentials("  zeipar@gmail.com  ", "lalala")

      expect(@user).to be_an_instance_of(User)
    end

    it "is valid with the capitalized email address" do
      User.create(first_name: "tester1", last_name: "erer", email: "zeipar@gmail.com", password: "lalala", password_confirmation: "lalala")
      @user = User.authenticate_with_credentials("zEiPar@Gmail.CoM  ", "lalala")

      expect(@user).to be_an_instance_of(User)
    end


  end
end
