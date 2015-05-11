require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
  	@user = build(:user)
  end

  it "should have the right attributes" do
  	expect(@user).to respond_to(:first_name, :last_name, 
  														  :user_name, :email, :admin,
                                :password, :password_confirmation, 
                                :remember_token)
  end

  it "is valid with firstname, lastname, username, email, password, and password_confirmation" do
  	expect(@user).to be_valid
  end

  it "is invalid without a firstname" do
  	@user.first_name = ""
  	expect(@user).not_to be_valid
  	expect(@user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid with a firstname that is too long" do
  	@user.first_name = "a" * 51
  	expect(@user).not_to be_valid
  end

  it "is invalid without a lastname" do
  	@user.last_name = ""
  	expect(@user).not_to be_valid
  	expect(@user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid with a password that is too short" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user).not_to be_valid
  end

  it "is invalid without a username" do
  	@user.user_name = ""
  	expect(@user).not_to be_valid
  end

  it "is invalid with a username that is too long" do
    @user.user_name = "a" * 51
    expect(@user).not_to be_valid
  end

  it "is invalid with a username that is too short" do
    @user.user_name = "a" * 5
    expect(@user).not_to be_valid
  end

  it "is valid with a user name that starts with a letter and contains numbers and letters" do
    valid_user_name = %w(l123456, JohnJeffers, alpha123, flyguts, craig125Jeffrey)
    valid_user_name.each do |name|
      @user.user_name = name
    end
    expect(@user).to be_valid
  end

  it "is invalid with a user name that starts with a number or contains anything other than numbers and letters" do
    valid_user_name = %w(john%jeffers, 1Craigd, jasper_havers)
    valid_user_name.each do |name|
      @user.user_name = name
    end
    expect(@user).to_not be_valid
  end

  it "is invalid with a user name that is not unique" do
    @user.save
    @new_user = build(:user, user_name: @user.user_name.upcase)
    expect(@new_user).to_not be_valid
  end

  it "is invalid without an email" do
  	@user.email = ""
  	expect(@user).not_to be_valid
  end

  it "is valid with an acceptable email format" do
    valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn)
    valid_addresses.each do |address|
      @user.email = address
      expect(@user).to be_valid
    end
  end

  it "is invalid with an invalid email format" do
    valid_addresses = %w(user@example,com user_at_foo.org user.name@example.
                      foo@bar_baz.com foo@bar+baz.com)
    valid_addresses.each do |address|
      @user.email = address
      expect(@user).to_not be_valid
    end
  end

  it "is invalid if the email isn't unique" do
    @user.save
    @new_user = build(:user, email: @user.email)
    expect(@new_user).to_not be_valid
  end

  































end
