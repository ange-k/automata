class AddColumnScore < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :score,   :float, :after => :category_id
    add_column :tweets, :correct, :integer, :after => :score
    add_index :tweets, :correct
  end
end
