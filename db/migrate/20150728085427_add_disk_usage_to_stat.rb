class AddDiskUsageToStat < ActiveRecord::Migration
  def change
  	add_column :stats, :disk_usage, :float, :after => :memory_taken
  end
end
