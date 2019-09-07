class Item < ApplicationRecord
  belongs_to :list

  acts_as_list scope: :list

  validates :name, presence: true

  scope :persisted, -> { where "id IS NOT NULL" }
  scope :complete, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
end
