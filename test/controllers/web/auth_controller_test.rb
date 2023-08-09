# frozen_string_literal: true

require 'test_helper'

module Web
  class AuthControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user_one = users(:one)
    end

    test '#request :github' do
      post auth_request_path('github')

      assert_redirected_to callback_auth_path(:github)
    end

    test '#callback sign_up' do
      user = User.new(email: 'new@email.com', name: 'new')
      sign_in(user)

      assert_redirected_to root_path

      assert User.find_by(email: user.email)
      assert { signed_in? }
    end

    test '#callback sign_in' do
      sign_in(@user_one)
      assert { signed_in? }
    end

    test '#destroy' do
      delete auth_logout_url

      assert_redirected_to root_path
    end
  end
end
