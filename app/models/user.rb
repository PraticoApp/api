class User < ApplicationRecord
  enum gender: %i[female male not_telling]

  has_secure_password
  has_secure_token :authentication_token

  has_one :address, dependent: :destroy
  has_many :competencies, dependent: :destroy
  has_many :skills, through: :competencies

  validates :first_name, presence: true
  validates :cpf, presence: true, uniqueness: true, length: { is: 11 }
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  validates :gender, presence: true
  validates :birth_date, presence: true

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage/.*\z}

  accepts_nested_attributes_for :address, reject_if: :all_blank
end
