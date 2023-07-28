require 'test_helper'

module Web
  class ProfileControllerTest < ActionDispatch::IntegrationTest
    test 'should redirect unregistered user to root' do
      get profile_url

      assert_response :redirect
    end

    test 'should get profile' do
      @user_one = users(:one)
      sign_in(@user_one)
      get profile_url

      assert_response :success
    end
  end
end
