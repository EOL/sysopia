class Stat < ActiveRecord::Base
  DAY = 86400
  MONTH = 2592000

  class << self
    def last_day(stat = nil)
      last_period(DAY, stat)
    end

    def last_month(stat = nil)
      last_period(MONTH, stat)
    end

    private
    def last_period(period, stat)
      mod_val = (period.to_f/DAY).round
      mod_val = 1 if mod_val < 1
      period = Sysopia.now - period
      data = {}
      res = nil
      if stat
        return Stat.where("timestamp > #{period}").order(:comp_id).
          select("id, comp_id, timestamp, #{stat}")
      else
        return Stat.where("timestamp > #{period}").where("mod(id, 1) = 0").
          order(:comp_id)
      end
    end
  end
end
