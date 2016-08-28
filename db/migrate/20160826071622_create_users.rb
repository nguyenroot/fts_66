class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :chatwork_id
      t.integer :role, default: 0
      t.string :avatar_path

      t.timestamps null: false
    end
  end
end
