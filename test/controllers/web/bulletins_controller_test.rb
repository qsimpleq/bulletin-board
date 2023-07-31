# frozen_string_literal: true

require 'test_helper'

module Web
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
        post bulletins_url, params: { bulletin: @attrs }
      end

      assert_redirected_to profile_url
    end

    test 'should get edit' do
      get edit_bulletin_url(@bulletin)

      assert_response :success
    end

    test 'should update bulletin' do
      patch bulletin_url(@bulletin), params: { bulletin: @attrs }

      assert_redirected_to profile_url
    end

    test 'transition to moderate' do
      patch moderate_bulletin_path(@bulletin)

      assert_response :redirect
    end

    test 'transition to archive' do
      patch archive_bulletin_path(@bulletin)

      assert_response :redirect
    end

    test 'anonymous transition to moderate' do
      delete auth_logout_path
      patch moderate_bulletin_path(@bulletin)

      assert_redirected_to root_path
    end

    test 'anonymous transition to archive' do
      delete auth_logout_path
      patch archive_bulletin_path(@bulletin)

      assert_redirected_to root_path
    end
  end
end
