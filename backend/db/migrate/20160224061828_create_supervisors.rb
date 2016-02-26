class CreateSupervisors < ActiveRecord::Migration
  def change
    create_table :supervisors do |t|
      t.string :name

      t.boolean :approved, :null => false
      t.index :approved

      t.integer :degree_id, :null => false
      t.integer :person_id, :null => false
      t.integer :supervisor_id, :null => false

      t.index :degree_id
      t.index :person_id
      t.index :supervisor_id

      t.timestamps null: false
    end
  end
end
