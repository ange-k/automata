class AddUserScreenName < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :screen_name, :string, :after => :name
    add_column :tweets, :link, :string, :after => :text
  end
end
