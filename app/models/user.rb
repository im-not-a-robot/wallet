class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true, format: { with: /\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+/ }
  validates :name, presence: true
end
