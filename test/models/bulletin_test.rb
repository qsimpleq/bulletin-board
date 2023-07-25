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
  # test "the truth" do
  #   assert true
  # end
end
