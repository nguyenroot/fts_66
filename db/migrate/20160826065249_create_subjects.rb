class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :question_number
      t.integer :duration
      t.string :image_path

      t.timestamps null: false
    end
  end
end
