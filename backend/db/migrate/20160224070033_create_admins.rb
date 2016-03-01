class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.timestamps null: false
      t.boolean :approved, :null => false
      t.index :approved
      t.integer :user_id, :null => false
    end
  end
end