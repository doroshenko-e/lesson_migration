class CreateTableUser < ActiveRecord::Migration

  def change
  	create_table :users do |t|
  		t.string :name, null: false
  		t.text :adress
  		t.timestamp
  	end
  end

end
