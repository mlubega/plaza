class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.integer :school_id
      t.string :course_number

      t.timestamps
    end
  end
end
