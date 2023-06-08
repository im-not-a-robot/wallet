class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :action

  validates :user, :action, :debit, :credit, presence: true
end
