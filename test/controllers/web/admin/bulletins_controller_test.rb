# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user_one = users(:one)
        @bulletin_one = bulletins(:one)

        sign_in(@user_one)

        @attrs = { category_id: @bulletin_one.category_id,
                   description: @bulletin_one.description,
                   title: @bulletin_one.title,
                   image: load_image('vehicle_car.jpg') }
        @bulletin = Bulletin.create(@attrs)
      end

      test 'check transition to archive' do
        patch archive_admin_bulletin_path(@bulletin)

        assert_response :redirect
      end

      test 'check transition to moderate' do
        patch moderate_admin_bulletin_path(@bulletin)

        assert_response :redirect
      end

      test 'check transition to reject' do
        @bulletin.update(state: 'under_moderation')
        patch reject_admin_bulletin_path(@bulletin)

        assert_response :redirect
      end

      test 'check transition to publish' do
        @bulletin.update(state: 'under_moderation')
        patch publish_admin_bulletin_path(@bulletin)

        assert_response :redirect
      end

      test 'anonymous transition to archive' do
        delete auth_logout_path
        patch archive_admin_bulletin_path(@bulletin)

        assert_redirected_to root_path
      end

      test 'anonymous transition to moderate' do
        delete auth_logout_path
        patch moderate_admin_bulletin_path(@bulletin)

        assert_redirected_to root_path
      end

      test 'anonymous transition to reject' do
        delete auth_logout_path
        patch reject_admin_bulletin_path(@bulletin)

        assert_redirected_to root_path
      end

      test 'anonymous transition to publish' do
        delete auth_logout_path
        patch publish_admin_bulletin_path(@bulletin)

        assert_redirected_to root_path
      end
    end
  end
end
