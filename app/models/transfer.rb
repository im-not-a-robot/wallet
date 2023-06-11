class Transfer < ApplicationRecord
  belongs_to :ref_transaction, class_name: 'Transaction'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates :ref_transaction, :recipient, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
