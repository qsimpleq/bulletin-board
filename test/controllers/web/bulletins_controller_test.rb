# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @bulletin = bulletins(:one)
    end

    test 'should get index' do
      get bulletins_url

      assert_response :success
    end

    test 'should get new' do
      get new_bulletin_url

      assert_redirected_to root_url
    end

    test 'should create bulletin' do
      assert_difference('Bulletin.count') do
        post bulletins_url,
             params: { bulletin: { description: @bulletin.description + '1',
                                   title: @bulletin.title + '1' } }
      end

      assert_redirected_to bulletins_url
    end

    test 'should show bulletin' do
      get bulletin_url(@bulletin)

      assert_response :success
    end
  end
end
