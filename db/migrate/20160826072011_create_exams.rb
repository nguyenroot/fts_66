class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.datetime :started_at
      t.integer :spent_time
      t.integer :status
      t.integer :score
      t.references :user, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
