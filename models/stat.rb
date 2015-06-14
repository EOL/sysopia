class Stat < ActiveRecord::Base
  require 'chronic'
  require 'ruby-units'
  DAY = 86400
  MONTH = 2592000

  class << self

    def time_window_and_offset(time_window, offset, stat = nil)
      end_ = Time.now - Unit.new(offset)
      start = end_ - Unit.new(time_window)
      last_period(start, end_, stat)
    end

    def start_and_length(start, length, stat = nil)
      start = Chronic.parse(start)
      end_ = start + Unit.new(length)  
      last_period(start, end_, stat)
    end

    def start_and_end(start, end_, stat = nil)      
      start = Chronic.parse(start)      
      end_ = Chronic.parse(end_ || Time.now.to_s)            
      last_period(start, end_, stat)
    end

    def ago(ago, stat = nil)     
      end_ = Time.now 
      start = end_ - Unit.new(ago)     
      last_period(start, end_, stat)
    end

    def last_day(stat = nil)
      end_ = Time.now 
      start = end_ - Unit.new("1d")
      last_period(start, end_, stat)
    end

    def last_month(stat = nil)
      end_ = Time.now 
      start = end_ - Unit.new("30d")
      last_period(start, end_, stat)
    end

    def last_week(stat = nil)
      end_= Time.now 
      start = end_ - Unit.new("7d")
      last_period(start, end_, stat)
    end

    private
    def last_period(start, end_ = 0, stat = nil)
      start = start.to_i
      end_ = end_.to_i    

      if stat
        return Stat.where("timestamp > #{start} AND timestamp < #{end_}").select("id, comp_id, timestamp, #{stat}")
      else        
        return Stat.where("timestamp > #{start} AND timestamp < #{end_}")
      end
    end
  end
end
