require_relative "../environment"
require_relative "systube/errors"
require_relative "systube/version"
require_relative "systube/stat"
require_relative "systube/chart_table"


# All-encompassing module of the project
module SysTube
  ONE_DAY = 86400
  HUNDRED_DAYS = 8640000
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new("/dev/null")
    end

    def next_day?
      Today.today != SysTube.today
    end

    def today
      Time.new.strftime("%Y-%m-%d")
    end

    def now
      Time.new.strftime("%s").to_i
    end
  end
end
