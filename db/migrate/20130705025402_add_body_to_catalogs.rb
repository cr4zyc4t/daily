class AddBodyToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :body, :text
  end
  def self.down
  	remove_column :catalogs, :body
  end
end
