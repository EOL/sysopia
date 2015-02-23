require_relative "../environment"
require_relative "systube/errors"
require_relative "systube/version"

# All-encompassing module of the project
module SysTube
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new("/dev/null")
    end
  end
end
