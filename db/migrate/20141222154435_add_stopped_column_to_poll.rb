class AddStoppedColumnToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :stopped, :boolean, default: false
  end
end
