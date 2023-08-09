# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class HomeControllerTest < ActionDispatch::IntegrationTest
      test '#show' do
        sign_in(users(:one))
        get admin_root_path

        assert_response :success
      end

      test '#show anonymous' do
        get admin_root_path

        assert_redirected_to root_path
      end
    end
  end
end
