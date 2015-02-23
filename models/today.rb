class Today < ActiveRecord::Base
  self.table_name = :today

  def self.today
    day = self.first || Today.create(today: SysTube.today)
    day.today
  end

  def self.new_today
    day = self.today
    day.today = SysTube.today
    day.save
  end
end
