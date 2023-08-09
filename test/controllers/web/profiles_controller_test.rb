# frozen_string_literal: true

require 'test_helper'

module Web
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    test '#show' do
      sign_in(users(:one))
      get profile_url

      assert_response :success
    end

    test '#show anonymous' do
      get profile_url

      assert_redirected_to root_path
    end
  end
end
