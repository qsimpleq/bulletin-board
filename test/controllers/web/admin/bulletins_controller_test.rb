# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user_one = users(:one)
        @bulletin_one = bulletins(:one)

        sign_in(@user_one)

        image_path = Rails.root.join('test/fixtures/files/vehicle_car.jpg')
        @image_file = fixture_file_upload(image_path, 'image/jpeg')
        @attrs = { category_id: @bulletin_one.category_id,
                   description: @bulletin_one.description,
                   title: @bulletin_one.title,
                   image: @image_file }
        @bulletin = Bulletin.create!(@attrs)
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

      test 'check transition to archive' do
        patch archive_admin_bulletin_path(@bulletin)

        assert_response :redirect
      end
    end
  end
end
