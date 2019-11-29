class User < ApplicationRecord
  belongs_to :account

  validates :first_name, :last_name, :email, presence: true

  include SoftDelete

  scope :order_by_name, -> { order(:last_name, :first_name) }

  scope :role_filter, ->(name) do
    case name
    when 'user'  then where(owner: false)
    when 'owner' then where(owner: true)
    else all
    end
  end

  scope :search, ->(query) do
    if query.present?
      where(
        "first_name ILIKE :query OR
         last_name  ILIKE :query OR
         email      ILIKE :query",
        query: "%#{query}%"
      )
    else
      all
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end
