# frozen_string_literal: true

require 'test_helper'

module Web
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    test 'should redirect unregistered user to root' do
      get profile_url

      assert_response :redirect
    end

    test 'should get profile' do
      sign_in(users(:one))
      get profile_url

      assert_response :success
    end
  end
end
