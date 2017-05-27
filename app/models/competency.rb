class Competency < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  validates :user, presence: true, uniqueness: { scope: :skill_id }
  validates :skill, presence: true, uniqueness: { scope: :user_id }
end
