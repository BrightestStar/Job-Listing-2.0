class AddMoreMigrationToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :wage_upper_bound, :integer
    add_column :jobs, :wage_lower_bound, :integer
    add_column :jobs, :contact_email, :string
  end
end
