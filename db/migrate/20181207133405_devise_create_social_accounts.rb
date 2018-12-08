# frozen_string_literal: true

class DeviseCreateSocialAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :social_accounts do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :social_accounts, :email,                unique: true
    add_index :social_accounts, :reset_password_token, unique: true
    # add_index :social_accounts, :confirmation_token,   unique: true
    # add_index :social_accounts, :unlock_token,         unique: true
  end
end
