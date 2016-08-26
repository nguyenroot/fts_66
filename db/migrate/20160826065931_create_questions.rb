class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :type
      t.integer :status
      t.references :subject, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
