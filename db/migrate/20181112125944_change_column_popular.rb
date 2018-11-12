class ChangeColumnPopular < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :categories, :name, unique: true
    add_column :populars, :category_id, :integer, :null =>false
    add_index :populars,  :category_id
  end
end
