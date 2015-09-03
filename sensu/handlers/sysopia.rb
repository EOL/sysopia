#!/opt/sensu/embedded/bin/ruby

require "sensu-handler"
require "json"
require "mysql2"
require "inifile"

class Sysopia < Sensu::Handler
  GRANULARITY = [10,9,8,7,6,5,4,3,2,1]

  FIELDS = {
    procs_waiting: "processes_waiting",
    procs_uninterruptible: "processes_iowaiting",
    memory_percent: "memory_taken",
    memory_total: nil,
    swap_swap_used: "swap_used",
    swap_in: "swap_in",
    swap_out: "swap_out",
    io_read: "io_read",
    io_write: "io_write",
    system_interrupts_per_second: "interrups",
    system_context_switches_per_second: "context_switches",
    cpu_number: nil,
    cpu_user: "cpu_user",
    cpu_system: "cpu_system",
    cpu_busy: "cpu_busy",
    cpu_iowaiting: "cpu_wait",
    load_per_cpu_one_minute: "load_one",
    load_per_cpu_five_minutes: "load_five",
    load_per_cpu_fifteen_minutes: "load_fifteen",
    disk_usage: "disk_usage"
  }
  # override filters from Sensu::Handler. not appropriate for metric handlers
  def filter; end

  def comp_id(db, line)
    comp = line.split(" ").first.split(".").first
    res = db.query("select id from comps where sensu_name='#{comp}'")
    unless res.first
      db.query("insert into comps (sensu_name) values ('#{comp}')")
      res = db.query("select last_insert_id() as id")
    end
    res.first["id"]
  end

  def get_mins_id(db, mins)
    mins_id = db.query("select id from minutes where minutes = #{mins}").first
    if mins_id
      mins_id["id"]
    else
      db.query("insert into minutes (minutes) values (#{mins})")
      db.query("select last_insert_id() as id").first["id"]
    end
  end

  def granularity(db, timestamp)
    idx = 0
    res = db.query("select id, timestamp from stats limit 1")
    if res.first
      mins = ((timestamp.to_i - res.first["timestamp"])/60.0).floor
      mins_id = get_mins_id(db, mins)
      idx = mins_id.to_s(2).reverse.index("1")
    end
    "'" + GRANULARITY[0..idx].join(",") + "'"
  end

  def enter_stats(db, output, id)
    columns = []
    values = []
    timestamp = nil
    output.each do |l|
      l = l.strip.split(" ")
      timestamp ||= l.last
      value = l[-2]
      field = l[0].split(".")[-2..-1].join("_").to_sym
      column = FIELDS[field]
      if column
        columns << column
        values << value
      end
    end
    columns << "timestamp"
    values << timestamp
    columns << "comp_id"
    values << id
    columns << "granularity"
    values << granularity(db, timestamp)
    columns = columns.join(",")
    values = values.join(",")
    db.query("insert into stats (#{columns}) values (#{values})")
  end

  def handle
    # mysql settings
    ini_file = settings["sysopia"]["mysqlini"]
    ini = IniFile.load(ini_file)
    section = ini["client"]
    db_host = section["host"]
    db_user = section["user"]
    db_pass = section["password"]
    db_database = section["database"]

    # event values
    client_id = @event["client"]["name"]
    check_name = @event["check"]["name"]
    check_issued = @event["check"]["issued"]
    check_status = @event["check"]["status"]
    output = @event["check"]["output"].split("\n")

    begin
      db = Mysql2::Client.new(host: db_host, username: db_user,
                              password: db_pass, database: db_database)
      id = comp_id(db, output[0])
      enter_stats(db, output, id)
    rescue Mysql2::Error => e
      puts e.errno
      puts e.error
    rescue => e
      puts e
    ensure
      db.close if db
    end
  end
end
