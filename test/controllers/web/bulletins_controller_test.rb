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

    test '#index' do
      get bulletins_url

      assert_response :success
    end

    test '#show' do
      get bulletin_url(@bulletin)

      assert_response :success
    end

    test '#new' do
      get new_bulletin_url

      assert_response :success
    end

    test '#create' do
      post bulletins_url, params: { bulletin: @attrs }

      assert_redirected_to profile_url

      assert Bulletin.find_by(title: @attrs[:title],
                              description: @attrs[:description],
                              category_id: @attrs[:category_id],
                              user_id: current_user.id)
    end

    test '#edit' do
      get edit_bulletin_url(@bulletin)

      assert_response :success
    end

    test '#update' do
      title = 'new_title'
      patch bulletin_url(@bulletin_one), params: { bulletin: { title: } }

      assert_redirected_to profile_url

      @bulletin_one.reload

      assert { @bulletin_one.title == title }
    end

    test '#archive' do
      patch archive_bulletin_path(@bulletin)

      assert_response :redirect

      @bulletin.reload

      assert { @bulletin.archived? }
    end

    test '#archive anonymous' do
      delete auth_logout_path
      patch archive_bulletin_path(@bulletin)

      assert_redirected_to root_path

      @bulletin.reload

      assert_not @bulletin.archived?
    end

    test '#moderate' do
      patch moderate_bulletin_path(@bulletin)

      assert_response :redirect

      @bulletin.reload

      assert { @bulletin.under_moderation? }
    end

    test '#moderate anonymous' do
      delete auth_logout_path
      patch moderate_bulletin_path(@bulletin)

      assert_redirected_to root_path

      @bulletin.reload

      assert_not @bulletin.under_moderation?
    end
  end
end
