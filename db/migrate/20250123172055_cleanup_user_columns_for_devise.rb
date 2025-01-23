class CleanupUserColumnsForDevise < ActiveRecord::Migration[8.0]
  def up
    # Remove the duplicate password columns
    remove_column :users, :password_digest if column_exists?(:users, :password_digest)
    
    # Make sure encrypted_password is set up correctly
    unless column_exists?(:users, :encrypted_password)
      add_column :users, :encrypted_password, :string, null: false, default: ""
    end
  end

  def down
    add_column :users, :password_digest, :string unless column_exists?(:users, :password_digest)
  end
end
