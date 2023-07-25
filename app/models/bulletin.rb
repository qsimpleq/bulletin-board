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
class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :category, inverse_of: :bulletins, optional: false
  belongs_to :user, inverse_of: :bulletins, optional: true

  validates :description, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :image, presence: true,
                    attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  aasm(column: 'state') do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :moderate do
      transitions from: %i[draft rejected], to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :decline do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions to: %i[archived]
    end
  end

  scope :created_by, ->(user) { where(user_id: user.id) }
  scope :published, -> { where(state: 'published') }
  scope :under_moderation, -> { where(state: 'under_moderation') }

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id state title]
  end

  def self.states
    @states ||= aasm.states.map(&:name)
  end
end
