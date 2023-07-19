# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  admin      :boolean          default(TRUE), not null
#  email      :string
#  name       :string
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_admin             (admin)
#  index_users_on_email             (email)
#  index_users_on_name              (name)
#  index_users_on_provider          (provider)
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#  index_users_on_uid               (uid)
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
