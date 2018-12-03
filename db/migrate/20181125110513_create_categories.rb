class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :label, null: false
      t.timestamps
    end
    add_index :categories, :name, unique: true
    add_column :populars, :category_id, :integer, :null => true
    add_index :populars,  :category_id
    add_reference :tweets, :category, foreign_key: true, :after => :text
  end
end
