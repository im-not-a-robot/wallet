class Transaction < ApplicationRecord
  belongs_to :user

  validates :user, :action, :debit, :credit, :status, presence: true
end
