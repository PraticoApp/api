class User < ApplicationRecord
  enum gender: %i[female male not_telling]

  has_secure_password
  has_secure_token :authentication_token

  validates :first_name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :birth_date, presence: true
end
