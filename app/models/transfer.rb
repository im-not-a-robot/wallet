class Transfer < ApplicationRecord
  belongs_to :transaction
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates :transaction, :recipient, :amount, presence: true
end
