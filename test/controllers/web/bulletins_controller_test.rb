# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user_one = users(:one)
      @bulletin = bulletins(:one)
      sign_in(@user_one)
    end

    test 'should get index' do
      get bulletins_url

      assert_response :success
    end

    test 'should get new' do
      get new_bulletin_url

      assert_response :success
    end

    test 'should create bulletin' do
      assert_difference('Bulletin.count') do
        image_path = Rails.root.join('test/fixtures/files/vehicle_car.jpg')
        image_file = fixture_file_upload(image_path, 'image/jpeg')

        post bulletins_url, params: {
          bulletin: { category_id: @bulletin.category_id,
                      description: @bulletin.description,
                      title: @bulletin.title,
                      image: image_file }
        }
      end

      assert_redirected_to bulletins_url
    end

    test 'should show bulletin' do
      get bulletin_url(@bulletin)

      assert_response :success
    end
  end
end
