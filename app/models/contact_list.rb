class ContactList < ApplicationRecord
  # Constants

  # Validations
  validates :name, :number, presence: true
  validates :number, uniqueness: true
  validates :number, length: { is: 10 }

  # Callbacks

  # Methods
end
