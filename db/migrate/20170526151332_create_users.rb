class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, default: ''
      t.string :last_name
      t.string :email, null: false, default: ''
      t.string :password_digest, null: false, default: ''
      t.string :cpf, null: false, default: ''
      t.string :phone, null: false, default: ''
      t.integer :gender, null: false, default: 2
      t.date :birth_date, null: false, default: -> { 'CURRENT_DATE' }
      t.string :confirmation_token
      t.timestamp :confirmation_sent_at
      t.string :reset_password_token
      t.timestamp :reset_password_sent_at
      t.string :unconfirmed_email
      t.string :authentication_token
      t.boolean :active, null: false, default: false

      t.index :email, unique: true
      t.index :cpf, unique: true
      t.index :phone, unique: true
      t.index :confirmation_token, unique: true
      t.index :reset_password_token, unique: true
      t.index :authentication_token, unique: true

      t.timestamps
    end
  end
end
