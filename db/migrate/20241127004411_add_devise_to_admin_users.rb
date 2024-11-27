# frozen_string_literal: true

class AddDeviseToAdminUsers < ActiveRecord::Migration[7.2]
  def self.up
    change_table :admin_users, bulk: true do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: "" unless column_exists?(:admin_users, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:admin_users, :encrypted_password)

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:admin_users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:admin_users, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:admin_users, :remember_created_at)

      ## Trackable
      # Uncomment if you want to add these fields
      # t.integer  :sign_in_count, default: 0, null: false unless column_exists?(:admin_users, :sign_in_count)
      # t.datetime :current_sign_in_at unless column_exists?(:admin_users, :current_sign_in_at)
      # t.datetime :last_sign_in_at unless column_exists?(:admin_users, :last_sign_in_at)
      # t.string   :current_sign_in_ip unless column_exists?(:admin_users, :current_sign_in_ip)
      # t.string   :last_sign_in_ip unless column_exists?(:admin_users, :last_sign_in_ip)

      ## Confirmable
      # Uncomment if you want to add these fields
      # t.string   :confirmation_token unless column_exists?(:admin_users, :confirmation_token)
      # t.datetime :confirmed_at unless column_exists?(:admin_users, :confirmed_at)
      # t.datetime :confirmation_sent_at unless column_exists?(:admin_users, :confirmation_sent_at)
      # t.string   :unconfirmed_email unless column_exists?(:admin_users, :unconfirmed_email)

      ## Lockable
      # Uncomment if you want to add these fields
      # t.integer  :failed_attempts, default: 0, null: false unless column_exists?(:admin_users, :failed_attempts)
      # t.string   :unlock_token unless column_exists?(:admin_users, :unlock_token)
      # t.datetime :locked_at unless column_exists?(:admin_users, :locked_at)

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :admin_users, :email, unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
    # Uncomment the following lines if these indexes are needed
    # add_index :admin_users, :confirmation_token, unique: true unless index_exists?(:admin_users, :confirmation_token)
    # add_index :admin_users, :unlock_token, unique: true unless index_exists?(:admin_users, :unlock_token)
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    if column_exists?(:admin_users, :email)
      remove_index :admin_users, :email if index_exists?(:admin_users, :email)
      remove_column :admin_users, :email
    end
    if column_exists?(:admin_users, :encrypted_password)
      remove_column :admin_users, :encrypted_password
    end
    if column_exists?(:admin_users, :reset_password_token)
      remove_index :admin_users, :reset_password_token if index_exists?(:admin_users, :reset_password_token)
      remove_column :admin_users, :reset_password_token
    end
    remove_column :admin_users, :reset_password_sent_at if column_exists?(:admin_users, :reset_password_sent_at)
    remove_column :admin_users, :remember_created_at if column_exists?(:admin_users, :remember_created_at)
    # Add additional columns for rollback if needed
  end
end
