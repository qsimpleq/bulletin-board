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

      test 'should get index' do
        get admin_categories_url

        assert_response :success
      end

      test 'should get new' do
        get new_admin_category_url

        assert_response :success
      end

      test 'should create category' do
        assert_difference('Category.count') do
          post admin_categories_url, params: { category: { name: @category.name } }
        end

        assert_redirected_to admin_categories_url
      end

      test 'should get edit' do
        get edit_admin_category_url(@category)

        assert_response :success
      end

      test 'should update category' do
        patch admin_category_url(@category), params: { category: { name: @category.name } }

        assert_redirected_to admin_categories_url
      end

      test 'should destroy category' do
        assert_difference('Category.count', -1) do
          delete admin_category_url(@category)
        end

        assert_redirected_to admin_categories_url
      end
    end
  end
end
