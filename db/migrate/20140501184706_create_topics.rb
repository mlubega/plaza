class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :course_id
      t.timestamps
    end
    add_index :topics, :course_id
  end
end
