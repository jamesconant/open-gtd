class List < ApplicationRecord
  has_many :items, -> { order(position: :asc) }
  belongs_to :user

  scope :without_deleted, -> { where.not(name: 'Deleted') }

  validates :name, presence: true

  def self.deleted
    find_by(name: 'Deleted')
  end
end
