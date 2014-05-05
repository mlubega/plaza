class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
    
    add_index :enrollments, :course_id
    add_index :enrollments, :user_id
    add_index :enrollments, [:course_id, :user_id], unique:true
  end
end
