class AddColumnsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :byuser, :boolean
  end
end
