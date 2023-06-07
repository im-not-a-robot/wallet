class Stock < ApplicationRecord
  validates :symbol, :identifier, presence: true
end
