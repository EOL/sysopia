require_relative "../environment"
require_relative "sysopia/errors"
require_relative "sysopia/version"
require_relative "sysopia/stat"
require_relative "sysopia/chart_table"


# All-encompassing module of the project
module Sysopia
  ONE_DAY = 86400
  HUNDRED_DAYS = 8640000
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new("/dev/null")
    end

    def next_day?
      Today.today != Sysopia.today
    end

    def today
      Time.new.strftime("%Y-%m-%d")
    end

    def now
      Time.new.strftime("%s").to_i
    end
  end
end
