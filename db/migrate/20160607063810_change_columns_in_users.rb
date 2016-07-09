class ChangeColumnsInUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.rename :name, :first_name
      t.string :last_name
      t.date :birthday
      t.boolean :active
      t.remove :adress
    end
  end

  def down
    rename_column :users, :first_name, :name
    remove_column :users, :last_name
    remove_column :users, :bday
    remove_column :users, :active
    add_column :users, :adress, :string
  end
end
