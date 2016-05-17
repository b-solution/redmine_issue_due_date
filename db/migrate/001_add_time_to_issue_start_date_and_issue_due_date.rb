class AddTimeToIssueStartDateAndIssueDueDate < ActiveRecord::Migration
  def self.up
    change_column :issues, :start_date, :datetime
    change_column :issues, :due_date, :datetime
  end
  
  def self.down
    change_column :issues, :start_date, :date
    change_column :issues, :due_date, :date
  end
end
