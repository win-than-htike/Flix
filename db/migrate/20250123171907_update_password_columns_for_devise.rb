class UpdatePasswordColumnsForDevise < ActiveRecord::Migration[8.0]
  def up
    # Only rename if password_digest exists and encrypted_password doesn't
    if column_exists?(:users, :password_digest) && !column_exists?(:users, :encrypted_password)
      rename_column :users, :password_digest, :encrypted_password
    end

    # Add other Devise columns if they don't exist
    unless column_exists?(:users, :reset_password_token)
      add_column :users, :reset_password_token, :string
      add_column :users, :reset_password_sent_at, :datetime
      add_column :users, :remember_created_at, :datetime
      
      add_index :users, :email, unique: true
      add_index :users, :reset_password_token, unique: true
    end
  end

  def down
    if column_exists?(:users, :encrypted_password) && !column_exists?(:users, :password_digest)
      rename_column :users, :encrypted_password, :password_digest
    end

    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at

    remove_index :users, :email
    remove_index :users, :reset_password_token
  end
end
