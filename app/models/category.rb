# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name)
#
class Category < ApplicationRecord
  has_many :bulletins, dependent: :nullify

  validates :name, presence: true, length: { minimum: 1 }
end
