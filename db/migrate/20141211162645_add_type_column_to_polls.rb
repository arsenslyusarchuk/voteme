class AddTypeColumnToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :poll_type, :string
  end
end
