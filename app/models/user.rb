# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  provider   :string
#  uid        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email             (email)
#  index_users_on_name              (name)
#  index_users_on_provider          (provider)
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#  index_users_on_uid               (uid)
#
class User < ApplicationRecord
  validates :email, presence: true
  validates :name, presence: true
  validates :provider, presence: true, uniqueness: { scope: [:uid] } # , inclusion: { in: %i[github], message: '%<value>s is not supported' }
  validates :uid, presence: true

  def self.create_with_omniauth(auth)
    create(
      email: auth['info']['email'],
      name: auth['info']['name'],
      provider: auth['provider'],
      uid: auth['uid']
    )
  end

  def self.find_by_provider_and_uid(auth)
    where(provider: auth['provider'], uid: auth['uid'])
  end
end
