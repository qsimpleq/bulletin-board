# frozen_string_literal: true

# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  creator_id  :integer
#
# Indexes
#
#  index_bulletins_on_category_id  (category_id)
#  index_bulletins_on_creator_id   (creator_id)
#  index_bulletins_on_description  (description)
#  index_bulletins_on_title        (title)
#
class Bulletin < ApplicationRecord
  has_one_attached :image

  belongs_to :category, inverse_of: :bulletins, optional: false
  belongs_to :creator, class_name: 'User', inverse_of: :users, optional: true

  validates :description, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  # validates :image, presence: true,
  #                   attached: true,
  #                   content_type: %i[png jpg jpeg],
  #                   size: { less_than: 5.megabytes }
end
