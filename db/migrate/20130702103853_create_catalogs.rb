class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string :name

      t.timestamps
    end
  end
  def self.down
    drop_table :catalogs
  end
end
