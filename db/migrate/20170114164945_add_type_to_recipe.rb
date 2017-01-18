class AddTypeToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :type, :boolean, :default => true
  end
end
