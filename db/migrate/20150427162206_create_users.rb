class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :image
      t.string :token
      t.datetime :token_expires
      t.json :tagged_places

      t.timestamps
    end
  end
end
