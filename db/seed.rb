require "csv"
require_relative "../lib/sysopia"

unless [:development, :test, :production].include? Sysopia.env
  puts "Use: SYSOPIA=your_env.sh bundle exec rake seed"
  puts "your_env.sh should include all environment variables from" \
       "config/env.sh"
  exit
end

class Seeder
  MAX_TIMESTAMP = 1425598175
  attr :env_dir

  def initialize
    @db = ActiveRecord::Base.connection
    common_dir = File.join(__dir__, "seed")
    @env_dir = File.join(common_dir, Sysopia.env.to_s)
    @path = @columns = nil
    @offset = Time.new.strftime("%s").to_i - MAX_TIMESTAMP
  end

  def walk_path(path)
    @path = path
    files = Dir.entries(@path).map {|e| e.to_s}.select {|e| e.match /csv$/}
    puts("Files: #{files}")
    files.each do |file|
      add_seeds(file)
    end
    rescue ActiveRecord::StatementInvalid
      fail "\nBefore adding seeds run:\n" \
           "bundle exec SYSOPIA=your_env.sh rake db:migrate \n\n"
  end

  private

  def add_seeds(file)
    table = file.gsub(/\.csv/, "")
    @db.execute("truncate table %s" % table)
    data_slice_for table, file do |data|
      @db.execute("insert ignore into %s values %s" % [table, data]) if data
    end
  end

  def data_slice_for(table, file)
    all_data = collect_data(file, table)
    all_data.each_slice(1_000) do |s|
      data = s.empty? ? nil : "(#{s.join("), (")})"
      yield data
    end
  end

  def collect_data(file, table)
    @columns = @db.select_values("show columns from %s" % table)
    csv_args = { col_sep: "\t"}
    CSV.open(File.join(@path, file), csv_args).map do |row|
      row = get_row(row, table)
      (@columns.size - row.size).times { row << "null" }
      row.join(",")
    end
  end

  def get_row(row, table)
    row[1] = row[1].to_i + @offset if table == "stats"
    row.each_with_object([]) do |field, ary|
      value = (field == "\\N") ? "null" : @db.quote(field)
      ary << value
    end
  end
end

s = Seeder.new
s.walk_path(s.env_dir)
puts "You added seeds data to %s tables" % Sysopia.env.upcase
