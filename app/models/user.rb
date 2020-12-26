class User < ApplicationRecord
  belongs_to :account

  has_many :contacts, through: :account
  has_many :organizations, through: :account
  has_many :users, through: :account

  has_one_attached :photo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :registerable, :recoverable, :validatable
  devise :database_authenticatable, :rememberable

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validate :photo_is_web_image

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
    "#{last_name}, #{first_name}"
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    deleted_at ? :deleted : super
  end

  def demo?
    email == 'johndoe@example.com'
  end

  private

  def photo_is_web_image
    return unless photo.attached?
    return if photo.content_type.in?(Rails.application.config.active_storage.web_image_content_types)

    errors.add(:photo, 'Must be a .JPG, .PNG or .GIF file')
  end
end
