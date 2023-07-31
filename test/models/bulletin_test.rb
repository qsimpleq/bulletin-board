# frozen_string_literal: true

# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  description :text
#  state       :string           default("draft")
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#
# Indexes
#
#  index_bulletins_on_category_id  (category_id)
#  index_bulletins_on_description  (description)
#  index_bulletins_on_state        (state)
#  index_bulletins_on_title        (title)
#  index_bulletins_on_user_id      (user_id)
#
require 'test_helper'

class BulletinTest < ActiveSupport::TestCase
  setup do
    @bulletin_one = bulletins(:one)
  end

  test 'should do transition archive' do
    assert @bulletin_one.archive!
  end

  test 'should do transition moderate' do
    assert @bulletin_one.moderate!
  end

  test 'should do transition publish' do
    @bulletin_one.moderate!

    assert @bulletin_one.publish!
  end

  test 'should do transition reject' do
    @bulletin_one.moderate!

    assert @bulletin_one.reject!
  end
end
