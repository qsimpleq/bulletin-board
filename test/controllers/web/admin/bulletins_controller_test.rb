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

      test '#archive' do
        patch archive_admin_bulletin_path(@bulletin)

        assert_response :redirect

        @bulletin.reload

        assert { @bulletin.archived? }
      end

      test '#archive anonymous' do
        delete auth_logout_path
        patch archive_admin_bulletin_path(@bulletin)

        assert_redirected_to root_path

        @bulletin.reload

        assert_not @bulletin.archived?
      end

      test '#reject' do
        @bulletin.update(state: 'under_moderation')
        patch reject_admin_bulletin_path(@bulletin)

        assert_response :redirect

        @bulletin.reload

        assert { @bulletin.rejected? }
      end

      test '#reject anonymous' do
        delete auth_logout_path
        patch reject_admin_bulletin_path(@bulletin)

        assert_redirected_to root_path

        @bulletin.reload

        assert_not @bulletin.rejected?
      end

      test '#publish' do
        @bulletin.update(state: 'under_moderation')
        patch publish_admin_bulletin_path(@bulletin)

        assert_response :redirect

        @bulletin.reload

        assert { @bulletin.published? }
      end

      test '#publish anonymous' do
        delete auth_logout_path
        patch publish_admin_bulletin_path(@bulletin)

        assert_redirected_to root_path

        @bulletin.reload

        assert_not @bulletin.published?
      end
    end
  end
end
