class CreateCompetencies < ActiveRecord::Migration[5.1]
  def change
    create_table :competencies do |t|
      t.references :user, foreign_key: true, index: true
      t.references :skill, foreign_key: true, index: true

      t.timestamps
    end
  end
end
