class Account < ApplicationRecord
  has_many :organizations, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :name, presence: true
end
