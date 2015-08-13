class Today < ActiveRecord::Base
  self.table_name = :today

  def self.today
    day = self.first || Today.create(today: Sysopia.today)     
  end

  def self.new_today?
    day = self.today    
    if day.today != Sysopia.today    
      self.save_today 
      return true
    else
      return false
    end
  end

  def self.save_today 
    day = self.today
    day.today = Sysopia.today
    day.save
    day   
  end

end
