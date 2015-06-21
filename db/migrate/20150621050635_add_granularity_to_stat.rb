class AddGranularityToStat < ActiveRecord::Migration
  def up
  	execute <<-SQL
      ALTER TABLE stats
        ADD granularity SET('10','9','8','7','6','5','4','3','2','1')       
    SQL
  end

  def down
  	execute <<-SQL
      ALTER TABLE stats
        DROP COLUMN granularity       
    SQL
  end
end

