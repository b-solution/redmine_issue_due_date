class AddUseDatetimeForIssuesToProjects < ActiveRecord::Migration

  def self.up
    add_column :projects, :use_datetime_for_issues, :boolean, :default => false
  end

  def self.down
    remove_column :projects, :use_datetime_for_issues
  end

end
