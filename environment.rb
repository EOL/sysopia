require 'erb'
require "ostruct"
require "yaml"
require "active_record"
require "fileutils"

# All encompassing module for the project
module SysTube
  def self.env
    @env ||= ENV["SYSTUBE_ENV"] ? ENV["SYSTUBE_ENV"].to_sym : :development
  end

  def self.db_conf
    @db_conf ||= conf.database
  end

  def self.conf
    @conf ||= init_conf
  end

  def self.db_connection
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.logger.level = Logger::WARN
    ActiveRecord::Base.establish_connection(db_conf[env.to_s])
  end

  def self.read_env
    if ENV["SYSTUBE"]
      open(File.join(__dir__, ENV["SYSTUBE"])).each do |l|
        key, val = l.strip.split("=")
        ENV[key] = val if key && val
      end
    end
    self.check_env
  end

  def self.check_env
    e_required = open(File.join(__dir__, "config", "env.sh")).map do |l|
      key, val = l.strip.split("=")
      val && key
    end.compact
    e_real = ENV.keys.select { |k| k =~ /^SYSTUBE_/ }
    missing = e_required - e_real
    extra = e_real - e_required
    raise("Missing env variables: #{missing.join(', ')}") unless missing.empty?
    raise("Extra env variables: #{extra.join(', ')}") unless extra.empty?
  end

  private

  def self.init_conf
    raw_conf = File.read(File.join(__dir__, "config", "config.yml"))
    conf = YAML.load(ERB.new(raw_conf).result)
    OpenStruct.new(
      session_secret:   conf["session_secret"],
      database:         conf["database"],
      timezone_offset:  conf["timezone_offset"]
    )
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "models"))
Dir.glob(File.join(File.dirname(__FILE__), "models", "**", "*.rb")) do |app|
  require File.basename(app, ".*")
end

SysTube.read_env
SysTube.db_connection
