class AddedLocalitiesTable < ActiveRecord::Migration
  def change

  	create_table :localities do |t|
  		t.string 	:name
  		t.float 	:latitude
  		t.float 	:longitude

  		t.timestamps
  	end

  end
end
