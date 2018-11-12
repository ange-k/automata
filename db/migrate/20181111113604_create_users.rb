class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string   :tw_user_id, null: false
      t.string   :name, null: true
      t.integer  :followers_count, null: true, default: 0
      t.integer  :statuses_count, null: true, default: 0
      t.timestamps
    end
    add_index :users, [:tw_user_id], unique: true
  end
end
