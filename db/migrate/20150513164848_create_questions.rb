class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question
      t.integer :listing_id, index: true
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
