# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  def test_user_should_not_be_valid_and_saved_if_email_not_unique
    @user.save!

    test_user = @user.dup
    assert_not test_user.valid?

    assert_equal ["Email has already been taken"],
      test_user.errors.full_messages
  end

  def test_user_should_not_be_valid_without_email
    @user.email = ""
    assert_not @user.valid?

    @user.save
    assert_equal ["Email can't be blank", "Email is invalid"],
      @user.errors.full_messages
  end

  def test_user_should_have_password
    @user.password = nil
    assert_not @user.save

    assert_equal ["Password can't be blank",
       "Password confirmation doesn't match Password",
      "Password is too short (minimum is 6 characters)"],
      @user.errors.full_messages
  end

  def test_user_should_have_password_confirmation
    @user.password_confirmation = nil
    assert_not @user.save

    assert_equal ["Password confirmation can't be blank"],
      @user.errors.full_messages
  end

  def test_user_email_length
    @user.email = ("a" * 50) + "@test.com"
    assert @user.invalid?
  end
end
