class Contact < ApplicationRecord
  belongs_to :account
  belongs_to :organization, optional: true

  validates :first_name, :last_name, presence: true

  include SoftDelete

  scope :order_by_name, -> { order(:last_name, :first_name) }

  scope :search, ->(query) do
    if query.present?
      left_joins(:organization).
        where("contacts.first_name ILIKE :query OR
               contacts.last_name  ILIKE :query OR
               contacts.email      ILIKE :query OR
               organizations.name  ILIKE :query",
              query: "%#{query}%")
    else
      all
    end
  end

  def name
    "#{last_name}, #{first_name}"
  end
end
