# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user_one = users(:one)
        @category = categories(:one)
        sign_in(@user_one)
      end

      test '#index' do
        get admin_categories_url

        assert_response :success
      end

      test '#new' do
        get new_admin_category_url

        assert_response :success
      end

      test '#create' do
        name = 'new_name'
        post admin_categories_url, params: { category: { name: } }

        assert_redirected_to admin_categories_url

        assert Category.find_by(name:)
      end

      test '#edit' do
        get edit_admin_category_url(@category)

        assert_response :success
      end

      test '#update' do
        name = 'new_name'
        patch admin_category_url(@category), params: { category: { name: } }

        assert_redirected_to admin_categories_url

        @category.reload

        assert { @category.name == name }
      end

      test '#destroy with unprocessable_entity if bulletins linked' do
        delete admin_category_url(@category)

        assert_response :unprocessable_entity
      end

      test '#destroy' do
        delete admin_category_url(Category.find_by(name: 'three'))

        assert_redirected_to admin_categories_url

        assert_not Category.find_by(name: 'three')
      end
    end
  end
end
