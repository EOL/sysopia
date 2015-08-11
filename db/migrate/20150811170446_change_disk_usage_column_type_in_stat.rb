class ChangeDiskUsageColumnTypeInStat < ActiveRecord::Migration
  def change
  	change_column :stats, :disk_usage, :integer
  end
end
