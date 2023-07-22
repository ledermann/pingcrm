class Organization < ApplicationRecord
  belongs_to :account
  has_many :contacts, dependent: :destroy

  validates :name, presence: true

  include SoftDelete

  scope :search,
        ->(query) {
          if query.present?
            where('organizations.name ILIKE ?', "%#{query}%")
          else
            all
          end
        }
end
