class Skill < ApplicationRecord
  has_many :competencies, dependent: :destroy
  has_many :users, through: :competencies

  validates :name, presence: true, uniqueness: true
end
