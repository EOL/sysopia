class Today < ActiveRecord::Base
  self.table_name = :today

  def self.today
    day = self.first || Today.create(today: Sysopia.today)
    day.today
  end

  def self.new_today
    day = self.today
    day.today = Sysopia.today
    day.save
  end
end
