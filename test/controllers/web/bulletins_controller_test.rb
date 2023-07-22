# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user_one = users(:one)
      @bulletin = bulletins(:one)
      sign_in(@user_one)

      image_path = Rails.root.join('test/fixtures/files/vehicle_car.jpg')
      @image_file = fixture_file_upload(image_path, 'image/jpeg')
      @attrs = {
        bulletin: { category_id: @bulletin.category_id,
                    description: @bulletin.description,
                    title: @bulletin.title,
                    image: @image_file }
      }
    end

    test 'should get index' do
      get bulletins_url

      assert_response :success
    end

    test 'should show bulletin' do
      get bulletin_url(@bulletin)

      assert_response :success
    end

    test 'should get new' do
      get new_bulletin_url

      assert_response :success
    end

    test 'should create bulletin' do
      assert_difference('Bulletin.count') do
        post bulletins_url, params: @attrs
      end

      assert_redirected_to profile_url
    end

    test 'should get edit' do
      get edit_bulletin_url(@bulletin)

      assert_response :success
    end

    test 'should update bulletin' do
      patch bulletin_url(@bulletin), params: @attrs

      assert_redirected_to profile_url
    end
  end
end
