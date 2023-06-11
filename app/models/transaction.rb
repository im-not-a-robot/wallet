class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :action

  belongs_to :ref_transaction, class_name: "Transaction", optional: true

  validates :user, :action, :debit, :credit, presence: true

  after_save :update_balance

  def update_balance
    balance = Balance.find_by(user_id: self.user_id)
    balance.amount += self.credit
    balance.amount -= self.debit
    balance.save!
  end
end
