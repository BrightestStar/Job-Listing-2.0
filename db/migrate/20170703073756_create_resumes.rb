class CreateResumes < ActiveRecord::Migration[5.1]
  def change
    create_table :resumes do |t|
      t.text :body
      t.integer :job_id
      t.integer :user_id

      t.timestamps
    end
    add_index :resumes, :user_id
  end
end
