class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :uid
      t.string :name
      t.string :lat
      t.string :lang

      t.timestamps
    end
  end
end
