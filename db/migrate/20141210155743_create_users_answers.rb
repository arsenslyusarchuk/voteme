class CreateUsersAnswers < ActiveRecord::Migration
  def change
    create_table :answers_users do |t|
      t.references :answer
      t.references :user
    end
    add_index :answers_users, [:answer_id, :user_id]
    add_index :answers_users, :user_id
  end
end
